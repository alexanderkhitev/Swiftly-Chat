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
    
    /// contact id
    @objc dynamic var id = ""
    @objc dynamic var contactID = ""
    @objc dynamic var updateTimestamp = 0.0
    @objc dynamic var countryCode: Int64 = 0
    @objc dynamic var nationalNumber: Int64 = 0
    @objc dynamic var numberString = ""
    
    convenience init(contactID: String, updateTimestamp: Double, countryCode: Int64, nationalNumber: Int64, numberString: String) {
        self.init()
        self.contactID = contactID
        self.updateTimestamp = updateTimestamp
        self.countryCode = countryCode
        self.nationalNumber = nationalNumber
        self.numberString = numberString
        
        id = generateID()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    private func generateID() -> String {
        return contactID + numberString
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
            numberString <- map["numberString"]
        } else {
            id >>> map["id"]
            contactID >>> map["contactID"]
            updateTimestamp >>> map["updateTimestamp"]
            countryCode >>> map["countryCode"]
            nationalNumber >>> map["nationalNumber"]
            numberString >>> map["numberString"]
        }
    }

    
}
