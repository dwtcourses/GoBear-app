//
//  GoBearProductsRequest.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import Alamofire

final class GoBearProductsRequest: Request {
    
    // Type
    typealias Element = [ProductObj]
    
    // Endpoint
    var endpoint: String { return Constant.GoBearApi.Feeds }
    
    // HTTP Method
    var httpMethod: HTTPMethod { return .get }
    
    // Decode
    func decode(data: Any) throws -> Element? {
        
        guard let result = data as? Data else {
            return nil
        }
        
        let products = self.parserXML(result)[Constant.Object.Product.RSS][Constant.Object.Product.Channel][Constant.Object.Product.Item].all
        
        return try products.map { try ProductObj($0) }
    }
}
