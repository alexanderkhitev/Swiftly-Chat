//
//  DeviceContactsManager.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/22/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import Contacts
import Promises
import RealmSwift

class DeviceContactsManager {
    
    open func requestContactsAccess() -> Promise<Bool> {
        let promise = Promise<Bool>(on: .global(qos: .background)) { fulfill, reject in
            let status = CNContactStore.authorizationStatus(for: .contacts)
            
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self.getAllPhoneContacts()
                }
            case .denied:
                // show
                fulfill(false)
            case .notDetermined, .restricted:
                CNContactStore().requestAccess(for: .contacts) { (isAccess, error) in
                    if let _error = error {
                        reject(_error)
                        return
                    }
                    if isAccess {
                        DispatchQueue.main.async {
                            self.getAllPhoneContacts()
                        }
                    }
                    fulfill(isAccess)
                }
            }
        }
        return promise
    }
    
    private func getAllPhoneContacts() {
        let contactStore = CNContactStore()
        var contacts = [CNContact]()
        guard let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey] as? [CNKeyDescriptor] else { return }
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            try contactStore.enumerateContacts(with: request, usingBlock: { (contact, _) in
                contacts.append(contact)
            })
        } catch {
            debugPrint(error.localizedDescription)
        }
        
        var deviceContacts = [DeviceContactModel]()
        
        let phoneNumberManager = PhoneNumberManager()
        for contact in contacts {
            let deviceContact = DeviceContactModel(id: contact.identifier, givenName: contact.givenName, familyName: contact.familyName)
            deviceContact.isNew = true
            
            let timestamp = Date().currentTimestamp
            
            for number in contact.phoneNumbers {
                if let phone = phoneNumberManager.parse(number.value.stringValue) {
                    let deviceContactPhone = DeviceContactPhoneModel(contactID: contact.identifier, updateTimestamp: timestamp, countryCode: Int64(phone.countryCode), nationalNumber: Int64(phone.nationalNumber))
                    deviceContact.phones.append(deviceContactPhone)
                }
            }
            deviceContacts.append(deviceContact)
        }
        
        let oldContacts = getLocalSavedDeviceContacts()
        let allContacts = oldContacts + deviceContacts
        var newContacts = allContacts.removeRepetingItems
        newContacts = newContacts.filter({ $0.isNew == true })
        debugPrint("newContacts", newContacts.count)
//        guard newContacts.count > 0 else { return }
        
        let contactsManager = ContactsManager()
        // new contacts
        contactsManager.syncContacts(deviceContacts).then { (_) in
            
        }.catch(on: .main) { (error) in
            debugPrint(error.localizedDescription)
        }
    }
    
    private func getLocalSavedDeviceContacts() -> [DeviceContactModel] {
        do {
            let realm = try Realm()
            let contacts = Array(realm.objects(DeviceContactModel.self))
            return contacts
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }
    
}
