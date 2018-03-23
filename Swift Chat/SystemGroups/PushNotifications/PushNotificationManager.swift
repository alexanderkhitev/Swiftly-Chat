//
//  PushNotificationManager.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/24/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import UIKit

class PushNotificationManager {
    
    func registerPushNotification() {
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func unregisterPushNotification() {
        UIApplication.shared.unregisterForRemoteNotifications()
    }
    
}
