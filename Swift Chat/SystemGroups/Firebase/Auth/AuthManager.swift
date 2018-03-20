//
//  AuthManager.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/20/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation

class AuthManager {
    
    enum `Type` {
        case phone
    }
    
    open func auth(_ type: Type) {
        switch type {
        case .phone:
            break 
        }
    }
    
}
