//
//  PhoneNumberManager.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/21/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import PhoneNumberKit

class PhoneNumberManager {
    
    open func parse(_ phone: String) {
        let phoneNumberKit = PhoneNumberKit()
        do {
            let phoneNumber = try phoneNumberKit.parse(phone)
            
            debugPrint("countryCode", phoneNumber.countryCode, "nationalNumber", phoneNumber.nationalNumber, "numberString", phoneNumber.numberString, phoneNumber.type)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}
