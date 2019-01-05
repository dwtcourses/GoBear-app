//
//  Identifier.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation

// MARK: - Identifier protocol
public protocol Identifier {
    
    static var identifier: String { get }
    
    static func xib() -> UINib
}
