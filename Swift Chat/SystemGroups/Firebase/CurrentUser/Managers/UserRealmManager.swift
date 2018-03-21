//
//  UserRealmManager.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/21/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import RealmSwift
import Promises

class UserRealmManager {
    
    open func saveUser(_ user: UserModel) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(user, update: true)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}
