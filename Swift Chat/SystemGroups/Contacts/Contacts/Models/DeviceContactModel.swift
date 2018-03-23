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
    
    open override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? DeviceContactModel else { return false }
        if id == object.id {
            var phonesEqual = false
            
//            if phones == nil {
//                debugPrint("phones == nil")
//            } else {
//                debugPrint("phones != nil")
//            }
            
//            if let currentPhones = phones, let otherPhones = object.phones {
                if phones.count == object.phones.count {
                    phonesEqual = phones.elementsEqual(object.phones, by: { (first, second) -> Bool in
                        return first.id == second.id && first.nationalNumber == second.nationalNumber
                    })
                }
//            }
            debugPrint("phonesEqual", phonesEqual)
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
                    phoneDict[phone.id] = phone.toJSON()
                }
                phoneDict >>> map["phones"]
//            }
        }
    }
    
}
