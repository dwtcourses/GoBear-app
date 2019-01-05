//
//  Request.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

typealias HeaderParameter = [String: String]

// MARK: - Request Protocol
protocol Request: URLRequestConvertible {
    
    associatedtype Element
    
    var basePath: String { get }
    
    var endpoint: String { get }
    
    var addionalHeader: HeaderParameter? { get }
    
    var httpMethod: HTTPMethod { get }
    
    var isAuthenticated: Bool { get }
    
    func decode(data: Any) throws -> Element?
}
