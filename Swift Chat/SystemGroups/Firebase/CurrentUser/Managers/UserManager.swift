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
import ObjectMapper

class UserManager {
    
    // MARK: - Saving functions
    
    open func saveNewUser(_ user: UserModel) -> Promise<Bool> {
        let promise = Promise<Bool>(on: .main) { fulfill, reject in
            let currentTimestamp = Date().currentTimestamp
            user.createdTimestamp = currentTimestamp
            user.updateTimestamp = currentTimestamp
            user.phoneInfo?.updateTimestamp = currentTimestamp
            
            user.isMain = true
            
            // save in realm
            
            let userRealmManager = UserRealmManager()
            
            let localSaveUserProm = userRealmManager.saveUser(user)
            let saveInDBProm = self.saveNewUserInDatabase(user)
            
            all([localSaveUserProm, saveInDBProm]).then({ (_) in
                fulfill(true)
            }).catch({ (error) in
                reject(error)
            })
        }
        return promise
    }
    
    private func saveNewUserInDatabase(_ user: UserModel) -> Promise<Bool> {
        let userID = user.id
        let userJSON = user.toJSON()
        let promise = Promise<Bool>(on: .global(qos: .background)) { fulfill, reject in
            let ref = Database.database().reference().child(UsersPaths.Main.users.rawValue).child(userID)
            ref.setValue(userJSON, withCompletionBlock: { (error, _) in
                if let _error = error {
                    reject(_error)
                } else {
                    fulfill(true)
                }
            })
        }
        return promise
    }
    
    // MARK: - Downloading functions
    
    open func downloadUser(_ userID: String) -> Promise<Bool> {
        let promise = Promise<Bool>(on: .global(qos: .background)) { fulfill, reject in
            let ref = Database.database().reference().child(UsersPaths.Main.users.rawValue).child(userID)
            ref.observeSingleEvent(of: .value, with: { (snap) in
                guard snap.exists() else {
                    return
                }
                guard let json = snap.value as? [String: Any] else { return }
                guard let user = Mapper<UserModel>().map(JSON: json) else { return }
                
                let userRealmManager = UserRealmManager()
                userRealmManager.saveUser(user).then({ (_) in
                    fulfill(true)
                }).catch({ (error) in
                    reject(error)
                })
            }, withCancel: { (error) in
                reject(error)
            })
        }
        return promise
    }
    
}
