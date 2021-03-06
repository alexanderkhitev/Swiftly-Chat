//
//  Router.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/20/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import Firebase 

class Router {
    
    open func chooseStartController() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let window = delegate.window else { return }
        if Auth.auth().currentUser != nil {
            //
            let mainTabBarController = StoryboardManager.main.instantiateViewControllerWithIdentifier(MainTabBarController.self)
            window.rootViewController = mainTabBarController
        } else {
            // Register Group
            window.rootViewController = RegisterMainViewController()
        }
    }
    
    open func showMainTabBarController() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let window = delegate.window else { return }
        let mainTabBarController = StoryboardManager.main.instantiateViewControllerWithIdentifier(MainTabBarController.self)
        window.rootViewController = mainTabBarController
    }
    
}
