//
//  ContactsViewController.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/21/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        setupUISettings()
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
