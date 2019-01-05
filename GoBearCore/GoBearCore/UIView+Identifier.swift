//
//  UIView+Identifier.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation

// MARK: - Identifier
extension UIView: Identifier {
    
    public static var identifier: String {
        return String(describing: self)
    }
    
    public static func xib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
