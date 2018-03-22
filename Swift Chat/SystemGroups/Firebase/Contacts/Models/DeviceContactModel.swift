//
//  DeviceContactModel.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/22/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class DeviceContactModel: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var givenName = ""
    @objc dynamic var familyName = ""
    
    let phones = List<DeviceContactPhoneModel>()
    
    convenience init(id: String, givenName: String, familyName: String) {
        self.init()
        self.id = id
        self.givenName = givenName
        self.familyName = familyName
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }

    
}
