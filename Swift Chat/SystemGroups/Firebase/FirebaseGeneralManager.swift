//
//  FirebaseGeneralManager.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/20/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import Firebase

class FirebaseGeneralManager {
    
    private init () { }
    
    static let shared = FirebaseGeneralManager()
    
    open func configure() {
        FirebaseApp.configure()
    }
    

    private func enable() {
    
    }
    
}
