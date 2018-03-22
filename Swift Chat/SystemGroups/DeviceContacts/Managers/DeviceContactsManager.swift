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

class DeviceContactsManager {
    
    open func requestContactsAccess() -> Promise<Bool> {
        let promise = Promise<Bool>(on: .global(qos: .background)) { fulfill, reject in
            let status = CNContactStore.authorizationStatus(for: .contacts)
            
            switch status {
            case .authorized:
                self.getAllPhoneContacts()
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
                        self.getAllPhoneContacts()
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
        
        let phoneNumberManager = PhoneNumberManager()
        for contact in contacts {
            debugPrint("familyName", contact.familyName, contact.givenName)
            for number in contact.phoneNumbers {
                if let phone = phoneNumberManager.parse(number.value.stringValue) {
                    debugPrint("number.value", number.value, "phone", phone.countryCode, phone.numberString)
            
                }
            }
        }
    }
    
}
