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

class ContactsManager {
    
    open func syncContacts(_ contacts: [DeviceContactModel]) -> Promise<Bool> {
        let promise = Promise<Bool>(on: .main) { fulfill, reject in
            let contactsJSON = contacts.toJSON()
            
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
        return promise
    }
    
}
