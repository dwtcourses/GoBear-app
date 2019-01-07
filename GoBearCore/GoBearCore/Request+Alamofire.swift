//
//  Request+Alamofire.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

extension Request {
    public func asURLRequest() throws -> URLRequest {
        return self.buildURLRequest()
    }
}

extension Request {
    
    fileprivate func buildURLRequest() -> URLRequest {
        
        /// Init
        var request = URLRequest(url: self.url)
        request.httpMethod = self.httpMethod.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        /// Add addional Header if need
        if let additionalHeader = self.addionalHeader {
            for (key, value) in additionalHeader {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
