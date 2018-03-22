//
//  ContactsViewController.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/21/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    // MARK: - Managers
    
    private let deviceContactsManager = DeviceContactsManager()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        setupUISettings()
        // request
        requestContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableBiggerNaviBar(true)
    }
    
    // MARK: - Settings

    private func setupSettings() {
        definesPresentationContext = true
    }
    
    // MARK: - UI
    
    private func setupUISettings() {
        view.backgroundColor = .white
        navigationItem.title = "Contacts"
    }
    
    
}

// MARK: - Contacts

extension ContactsViewController {
    
    private func requestContacts() {
        deviceContactsManager.requestContactsAccess().then { (isAccess) in
            if isAccess {
                
            } else {
                
            }
        }.catch(on: .main) { (error) in
            HUD.showError(error.localizedDescription)
        }
    }
    
}
