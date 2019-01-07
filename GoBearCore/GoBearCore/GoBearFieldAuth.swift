//
//  GoBearFieldAuth.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/4/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - GoBearFieldAuth
public protocol GoBearFieldAuth {
    
    var title: String { get }
    
    var textString: Variable<String?> { get }
    var errorValue: Variable<String?> { get }
}

extension GoBearFieldAuth {
    
    func validateSize(_ value: String, size: (min: Int, max: Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    
    func validateString(_ value: String, pattern: String) -> Bool {
        let matched = NSPredicate(format: "SELF MATCHES %@", pattern)
        return matched.evaluate(with: value)
    }
}

// MARK: - GoBearUsernameField
public struct GoBearUsernameField: GoBearFieldAuth {
    
    // MARK: - Variable
    public var title: String = "Username"
    public var textString: Variable<String?> = Variable<String?>(nil)
    public var errorValue: Variable<String?> = Variable<String?>(nil)
    
    // MARK: - Validate
    func validate() -> Bool {
        
        guard let text = textString.value, !text.isEmpty else {
            
            errorValue.value = Constant.Error.Message.Login.Username.Empty
            return false
        }
        
        guard validateSize(text, size: (6, 100)) else {
            
            errorValue.value = Constant.Error.Message.Login.Username.Size
            return false
        }
        
        guard validateString(text, pattern: "\\w{6,100}") else {
            
            errorValue.value = Constant.Error.Message.Login.Username.ContainSpecChar
            return false
        }
        
        errorValue.value = nil
        return true
    }
}

// MARK: - GoBearPasswordField
public struct GoBearPasswordField: GoBearFieldAuth {
    
    // MARK: - Variable
    public var title: String = "Password"
    public var textString: Variable<String?> = Variable<String?>(nil)
    public var errorValue: Variable<String?> = Variable<String?>(nil)
    
    // MARK: - Validate
    func validate() -> Bool {
        
        guard let text = textString.value, !text.isEmpty else {
            
            errorValue.value = Constant.Error.Message.Login.Password.Empty
            return false
        }
        
        guard validateString(text, pattern: "(?=.*[a-z])(?=.*[A-Z]).{2,}") else {
            
            errorValue.value = Constant.Error.Message.Login.Password.UpperAndLowerCase
            return false
        }
        
        guard validateString(text, pattern: "(?=)(?!\\s).{1,}") else {
            
            errorValue.value = Constant.Error.Message.Login.Password.IncludeNumber
            return false
        }
        
        guard text.count >= 8 else {
            
            errorValue.value = Constant.Error.Message.Login.Password.Size
            return false
        }
        
        errorValue.value = nil
        return true
    }
}
