//
//  AuthManager.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/20/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import Firebase

class AuthManager {
    
    enum `Type` {
        case phone
    }
    
    weak var delegate: AuthManagerDelegate?
    
    private lazy var authPhoneManager: AuthPhoneManager = {
        let authPhoneManager = AuthPhoneManager()
        authPhoneManager.delegate = self
        return authPhoneManager
    }()
    
    open func auth(_ type: Type) {
        switch type {
        case .phone:
            authPhoneManager.auth()
        }
    }
    
    open func signOut() {
        do {
            try Auth.auth().signOut()
            let router = Router()
            router.chooseStartController()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}

// MARK: - AuthPhoneManager Delegate

extension AuthManager: AuthPhoneManagerDelegate {
    
    func authPhoneCompletion(_ error: Error?) {
        delegate?.authCompletion?(error)
    }
    
}
