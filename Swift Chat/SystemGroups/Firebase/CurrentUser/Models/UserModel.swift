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
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        if map.mappingType == .fromJSON {
            id <- map["id"]
            currentPhone <- map["currentPhone"]
            providerID <- map["providerID"]
            username <- map["username"]
        } else {
            id >>> map["id"]
            currentPhone >>> map["currentPhone"]
            providerID >>> map["providerID"]
            username >>> map["username"]
        }
    }


    
}
