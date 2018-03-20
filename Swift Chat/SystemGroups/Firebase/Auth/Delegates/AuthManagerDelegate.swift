//
//  AuthManagerDelegate.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/21/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation

@objc protocol AuthManagerDelegate {
    
    @objc optional func authCompletion(_ error: Error?)
    
}
