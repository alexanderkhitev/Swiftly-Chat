//
//  HUD.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/22/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import SVProgressHUD

class HUD {
    
    static open func showError(_ errorMessage: String?) {
        SVProgressHUD.showError(withStatus: errorMessage)
    }
    
}
