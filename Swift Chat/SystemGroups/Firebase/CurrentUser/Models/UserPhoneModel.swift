//
//  UserCurrentPhoneModel.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/21/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class UserPhoneModel: Object, Mappable {
    
    /// Equals userID
    @objc dynamic var id = ""
    @objc dynamic var updateTimestamp = 0.0
    @objc dynamic var countryCode: Int64 = 0
    @objc dynamic var nationalNumber: Int64 = 0
    @objc dynamic var numberString = ""

    convenience init(id: String, countryCode: Int64, nationalNumber: Int64, numberString: String) {
        self.init()
        self.id = id
        self.countryCode = countryCode
        self.nationalNumber = nationalNumber
        self.numberString = numberString
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        if map.mappingType == .fromJSON {
            id <- map["id"]
            updateTimestamp <- map["updateTimestamp"]
            countryCode <- map["countryCode"]
            nationalNumber <- map["nationalNumber"]
            numberString <- map["numberString"]
        } else {
            id >>> map["id"]
            updateTimestamp >>> map["updateTimestamp"]
            countryCode >>> map["countryCode"]
            nationalNumber >>> map["nationalNumber"]
            numberString >>> map["numberString"]
        }
    }
    
}
