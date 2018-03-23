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
import ObjectMapper_Realm

class DeviceContactModel: Object, Mappable {
    
    @objc dynamic var id = ""
    @objc dynamic var givenName = ""
    @objc dynamic var familyName = ""
    
    var isNew = false
    
//    var phones: List<DeviceContactPhoneModel>?
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
    
    override static func ignoredProperties() -> [String] {
        return ["isNew"]
    }
    
    open override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? DeviceContactModel else { return false }
        if id == object.id {
            var phonesEqual = false
            if phones.count == object.phones.count {
                phonesEqual = phones.elementsEqual(object.phones, by: { (first, second) -> Bool in
                    return first.id == second.id && first.nationalNumber == second.nationalNumber
                })
            }
            return phonesEqual
        }
        return false
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        if map.mappingType == .fromJSON {
            id <- map["id"]
            givenName <- map["givenName"]
            familyName <- map["familyName"]
//            phones <- (map["phones"], ListTransform<DeviceContactPhoneModel>())
        } else {
            id >>> map["id"]
            givenName >>> map["givenName"]
            familyName >>> map["familyName"]
//            if let _phones = phones {
                var phoneDict = [String: Any]()
                for phone in phones {
                    let key = phone.countryCode.description + phone.nationalNumber.description
                    phoneDict[key] = phone.toJSON()
                }
                phoneDict >>> map["phones"]
//            }
        }
    }
    
}
