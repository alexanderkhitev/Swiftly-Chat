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
    
    private lazy var authManager: AuthManager = {
        let authManager = AuthManager()
        authManager.delegate = self
        return authManager
    }()
    
    // MARK: - UI Elements
    
    private let signInButton = UIButton(type: .system)
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        // UI
        setupUISettings()
        addUIElements()
        // Buttons configurations
        setupButtonsConfigurations()
    }
    
    // MARK: - Override functions
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUIElementsPositions()
    }

    // MARK: - Settings
    
    private func setupSettings() {
        definesPresentationContext = true
    }
    
    // MARK: - UI Settings
    
    private func setupUISettings() {
        view.backgroundColor = .white
    }
    
    private func addUIElements() {
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signInButton)
    }
    
    private func setupUIElementsPositions() {
        signInButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: - Buttons' configuration
    
    private func setupButtonsConfigurations() {
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
    
}

// MARK: - Sign in

extension RegisterMainViewController {
    
    @objc private func signIn() {
        authManager.auth(.phone)
    }
    
}

extension RegisterMainViewController: AuthManagerDelegate {
    
    func authCompletion(_ error: Error?) {
        if let error = error {
            
        } else {
            let router = Router()
            router.showMainTabBarController()
        }
    }
    
}
