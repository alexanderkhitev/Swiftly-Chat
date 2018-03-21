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
    
    open func requestContactsAccess() {
        let promise = Promise<Bool>(on: .global(qos: .background)) { fulfill, reject in
            let status = CNContactStore.authorizationStatus(for: .contacts)
            
            switch status {
            case .authorized:
                break
            case .denied:
                // show
                break
            case .notDetermined, .restricted:
                CNContactStore().requestAccess(for: .contacts) { (isAccess, error) in
                    
                }
            }
        }
    }
    
}
