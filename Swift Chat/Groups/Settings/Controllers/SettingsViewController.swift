//
//  SettingsViewController.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/21/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Managers
    
    private let authManager = AuthManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Settings
        setupSettings()
        // UI
        setupUISettings()
        logOut()
    }
    
    // MARK: - Settings
    
    private func setupSettings() {
        definesPresentationContext = true
    }
    
    // MARK: - UI Settings
    
    private func setupUISettings() {
        view.backgroundColor = .white
    }

 

}

// TODO: - Delete it

extension SettingsViewController {
    
    private func logOut() {
        authManager.signOut()
    }
    
}
