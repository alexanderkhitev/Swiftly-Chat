//
//  AuthPhoneManager.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/20/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuthUI
import FirebasePhoneAuthUI

class AuthPhoneManager: NSObject {
    
    open func auth() {
        FUIAuth.defaultAuthUI()?.delegate = self
    
        let phoneProvider = FUIPhoneAuth.init(authUI: FUIAuth.defaultAuthUI()!)
        FUIAuth.defaultAuthUI()?.providers = [phoneProvider]
        
    }
    
}

extension AuthPhoneManager: FUIAuthDelegate {
    
}
