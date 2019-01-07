//
//  GoBearProductDetailRequest.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import Alamofire

final class GoBearProductDetailRequest: Request {
    
    // Type
    typealias Element = ProductObj
    
    // Endpoint
    var endpoint: String { return Constant.GoBearApi.BaseSanboxURL }
    
    // HTTP Method
    var httpMethod: HTTPMethod { return .get }
    
    // Decode
    func decode(data: Any) throws -> ProductObj? {
        
        guard let result = data as? Data else {
            return nil
        }
        
        return try ProductObj(self.parserXML(result))
    }
}
