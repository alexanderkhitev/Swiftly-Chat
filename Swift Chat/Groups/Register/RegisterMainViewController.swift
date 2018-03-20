//
//  RegisterMainViewController.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/20/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import UIKit

class RegisterMainViewController: UIViewController {
    
    // MARK: - Managers
    
    private let authManager = AuthManager()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        // UI
        setupUISettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        authManager.auth(.phone)
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
