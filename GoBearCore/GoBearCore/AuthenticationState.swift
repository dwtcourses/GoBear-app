//
//  AuthenticationState.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/4/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation

// MARK: - Authentication State
public enum AuthenticationState {
    
    // Authenticated successfully and valid token from Uber
    case authenticated
    
    // Otherwise case
    case unAuthenticated
}
