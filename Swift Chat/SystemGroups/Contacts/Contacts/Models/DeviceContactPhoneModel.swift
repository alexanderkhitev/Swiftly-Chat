//
//  DeviceContactPhoneModel.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/22/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class DeviceContactPhoneModel: Object, Mappable {
    
    @objc dynamic var id = ""
    @objc dynamic var contactID = ""
    @objc dynamic var updateTimestamp = 0.0
    @objc dynamic var countryCode: Int64 = 0
    @objc dynamic var nationalNumber: Int64 = 0
    
    convenience init(contactID: String, updateTimestamp: Double, countryCode: Int64, nationalNumber: Int64) {
        self.init()
        self.contactID = contactID
        self.updateTimestamp = updateTimestamp
        self.countryCode = countryCode
        self.nationalNumber = nationalNumber
        
        id = generateID()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    private func generateID() -> String {
        return contactID + countryCode.description + nationalNumber.description
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        if map.mappingType == .fromJSON {
            id <- map["id"]
            contactID <- map["contactID"]
            updateTimestamp <- map["updateTimestamp"]
            countryCode <- map["countryCode"]
            nationalNumber <- map["nationalNumber"]
        } else {
            id >>> map["id"]
            contactID >>> map["contactID"]
            updateTimestamp >>> map["updateTimestamp"]
            countryCode >>> map["countryCode"]
            nationalNumber >>> map["nationalNumber"]
        }
    }

    
}
