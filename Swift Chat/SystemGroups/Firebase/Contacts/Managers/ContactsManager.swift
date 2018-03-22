//
//  ContactsManager.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/22/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import Firebase
import Promises
import RealmSwift

class ContactsManager {
    
    open func syncContacts(_ contacts: [DeviceContactModel]) -> Promise<Bool> {
        let promise = Promise<Bool>(on: .main) { fulfill, reject in
            let syncContactsInDatabaseProm = self.syncContactsInDatabase(contacts)
            let syncContactsInLocalDatabase = self.syncContactsInLocalDatabase(contacts)
            
            all([syncContactsInDatabaseProm, syncContactsInLocalDatabase]).then({ (_) in
                fulfill(true)
            }).catch({ (error) in
                reject(error)
            })
        }
        return promise
    }
    
    private func syncContactsInDatabase(_ contacts: [DeviceContactModel]) -> Promise<Bool> {
        let promise = Promise<Bool>(on: .main) { fulfill, reject in
            let contactsJSON = contacts.toJSON()
            
            DispatchQueue.global(qos: .background).async {
                guard let userID = Auth.auth().currentUser?.uid else { return }
                let main = ContactsPaths.Main.self
                let ref = Database.database().reference().child(main.userContacts.rawValue).child(userID).child(main.userDeviceContacts.rawValue)
                
                ref.setValue(contactsJSON, withCompletionBlock: { (error, _) in
                    if let _error = error {
                        reject(_error)
                    } else {
                        fulfill(true)
                    }
                })

            }
        }
        return promise
    }
    
    private func syncContactsInLocalDatabase(_ contacts: [DeviceContactModel]) ->  Promise<Bool> {
        let promise = Promise<Bool>(on: .main) { fulfill, reject in
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(contacts, update: true)
                    fulfill(true)
                }
            } catch {
                debugPrint(error.localizedDescription)
                reject(error)
            }
        }
        return promise
    }
    
}
