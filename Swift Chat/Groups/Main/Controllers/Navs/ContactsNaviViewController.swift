//
//  ContactsNaviViewController.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/21/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import UIKit

class ContactsNaviViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        addController()
    }
    
    private func setupSettings() {
        definesPresentationContext = true
    }
    
    private func addController() {
        let contactsViewController = ContactsViewController()
        viewControllers = [contactsViewController]
    }
}
