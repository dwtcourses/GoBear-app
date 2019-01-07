//
//  NSError+Helper.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation

extension NSError {
    
    // Custom Message
    static func customMessage(_ message: String) -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: message]
        return NSError.init(domain: Constant.Error.Domain, code: Constant.Error.Code.Default, userInfo: userInfo)
    }
    
    // Unknow Error
    static func unknowError() -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "Unknow error"]
        return NSError.init(domain: Constant.Error.Domain, code: Constant.Error.Code.Default, userInfo: userInfo)
    }
    
    //
    static func mapperError() -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "Mapper data error"]
        return NSError.init(domain: Constant.Error.Domain, code: Constant.Error.Code.Default, userInfo: userInfo)
    }
    
    static func gobearError(data: Any?, code: Int) -> NSError {
        
        guard let dictionaryError = data as? [String: Any] else {
            return mapperError()
        }
        
        return NSError.init(domain: Constant.Error.Domain, code: code, userInfo: dictionaryError)
    }
}
