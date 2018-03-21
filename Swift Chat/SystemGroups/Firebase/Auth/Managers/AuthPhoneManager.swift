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
    
    weak var delegate: AuthPhoneManagerDelegate?
    
    open func auth() {
        FUIAuth.defaultAuthUI()?.delegate = self
    
        let phoneProvider = FUIPhoneAuth(authUI: FUIAuth.defaultAuthUI()!)
        FUIAuth.defaultAuthUI()?.providers = [phoneProvider]
        
        guard let topVC = UIApplication.topViewController() else { return }
        
        phoneProvider.signIn(withPresenting: topVC, phoneNumber: nil)
    }
    
}

extension AuthPhoneManager: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            delegate?.authPhoneCompletion?(error)
        } else {
            guard let user = authDataResult?.user else { return }
            guard let phone = user.phoneNumber else { return }
            guard let additionalUserInfo = authDataResult?.additionalUserInfo else { return }
            
            let isNewUser = additionalUserInfo.isNewUser
            
            let newPhone = "89270139068"
            let phoneNumberManager = PhoneNumberManager()
            phoneNumberManager.parse(newPhone)
            
            if isNewUser {
                // save
                let userModel = UserModel(id: user.uid, currentPhone: phone, providerID: additionalUserInfo.providerID, username: nil)

            } else {
                // download
            }
                        
            delegate?.authPhoneCompletion?(nil)
        }
    }
    
}
