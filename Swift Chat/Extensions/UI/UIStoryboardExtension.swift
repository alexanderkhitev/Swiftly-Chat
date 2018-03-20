//
//  UIStoryboardExtension.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/20/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    func instantiateViewControllerWithIdentifier<T>(_ identifier: T.Type) -> T {
        let identifier = String(describing: identifier)
        return instantiateViewController(withIdentifier: identifier) as! T
    }
    
}
