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
    
    // MARK: - Settings

    private func setupSettings() {
        definesPresentationContext = true
    }
    
    // MARK: - UI
    
    private func setupUISettings() {
        view.backgroundColor = .white
    }
    
}
