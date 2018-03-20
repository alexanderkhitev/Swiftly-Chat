//
//  MainTabBarController.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/21/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // settings
        setupSettings()
    }
    
    // MARK: - Settings
    
    private func setupSettings() {
        definesPresentationContext = true
    }

}
