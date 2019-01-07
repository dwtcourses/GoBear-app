//
//  Request+Error.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

extension Request {
    
    func handleValidation(_ response: DefaultDataResponse) -> NSError? {
        
        /// No Response
        guard let inResponse = response.response else {
            return nil
        }
        
        /// Get Status Code
        let statusCode = inResponse.statusCode
        
        if 200...300 ~= statusCode {
            return nil
        }
        
        return NSError.gobearError(data: response.data, code: statusCode)
    }
}
