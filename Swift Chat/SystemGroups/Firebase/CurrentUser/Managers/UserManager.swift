//
//  UserManager.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/21/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import Firebase
import Promises

class UserManager {
    
    open func saveNewUser(_ user: UserModel) -> Promise<Bool> {
        let promise = Promise<Bool>(on: .main) { fulfill, reject in
            let currentTimestamp = Date().currentTimestamp
            user.createdTimestamp = currentTimestamp
            user.updateTimestamp = currentTimestamp
            
            user.isMain = true
            
            let userJSON = user.toJSON()
            // save in realm
            
            let userRealmManager = UserRealmManager()
            
            userRealmManager.saveUser(user)
            
        }
        return promise
    }
    
}
