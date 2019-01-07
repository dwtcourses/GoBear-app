//
//  UIViewController+Identifier.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIViewController
extension UIViewController: Identifier {
    
    public static var identifier: String {
        return String(describing: self)
    }
    
    public static func xib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public static func fromStoryboard<T: UIViewController>(_ storyboard: UIStoryboard?) -> T? {
        return storyboard?.instantiateViewController(withIdentifier: identifier) as? T
    }
}
