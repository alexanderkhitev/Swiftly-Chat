//
//  UserModel.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/21/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class UserModel: Object, Mappable {
    
    @objc dynamic var id = ""
    @objc dynamic var currentPhone = ""
    @objc dynamic var providerID = ""
    @objc dynamic var username: String?
    @objc dynamic var createdTimestamp = 0.0
    @objc dynamic var updateTimestamp = 0.0
    
    // local
    @objc dynamic var isMain = false
    
    // realm functions
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: String, currentPhone: String, providerID: String, username: String?) {
        self.init()
        self.id = id
        self.currentPhone = currentPhone
        self.providerID = providerID
        self.username = username
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        if map.mappingType == .fromJSON {
            id <- map["id"]
            currentPhone <- map["currentPhone"]
            providerID <- map["providerID"]
            username <- map["username"]
            // timestamps
            createdTimestamp <- map["createdTimestamp"]
            updateTimestamp <- map["updateTimestamp"]
        } else {
            id >>> map["id"]
            currentPhone >>> map["currentPhone"]
            providerID >>> map["providerID"]
            username >>> map["username"]
            // timestamps
            createdTimestamp >>> map["createdTimestamp"]
            updateTimestamp >>> map["updateTimestamp"]
        }
    }

    
}
