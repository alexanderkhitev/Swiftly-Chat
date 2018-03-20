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
            let result = authDataResult?.additionalUserInfo?.isNewUser
            let phone = authDataResult?.user.phoneNumber
            debugPrint("phone", phone, "result", result)
            delegate?.authPhoneCompletion?(nil)
        }
    }
    
}
