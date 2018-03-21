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
    
    private lazy var userManager: UserManager = {
        let userManager = UserManager()
        return userManager
    }()
    
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
            let userID = user.uid
            guard let phone = user.phoneNumber else { return }
            guard let additionalUserInfo = authDataResult?.additionalUserInfo else { return }
            
            let isNewUser = additionalUserInfo.isNewUser
            
            if isNewUser {
                // save
                let userModel = UserModel(id: userID, currentPhone: phone, providerID: additionalUserInfo.providerID, username: nil)
                saveUser(userModel, phone: phone)
            } else {
                // download
                downloadUser(userID)
            }
        }
    }
    
    private func saveUser(_ user: UserModel, phone: String) {
        let phoneNumberManager = PhoneNumberManager()
        if let extraPhoneInfo = phoneNumberManager.parse(phone) {
            let phoneModel = UserPhoneModel(id: user.id, countryCode: Int64(extraPhoneInfo.countryCode), nationalNumber: Int64(extraPhoneInfo.nationalNumber), numberString: extraPhoneInfo.numberString)
            user.phoneInfo = phoneModel
        }
        userManager.saveNewUser(user).then { (isCompleted) in
            if isCompleted {
                self.delegate?.authPhoneCompletion?(nil)
            } else {
                // TODO: - make custom error
            }
        }.catch { (error) in
            self.delegate?.authPhoneCompletion?(error)
        }
    }
    
    private func downloadUser(_ userID: String) {
        
    }
    
}
