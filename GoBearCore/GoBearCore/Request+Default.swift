//
//  Request+Default.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

// MARK: - Default implementation
extension Request {
    
    var basePath: String { return Constant.GoBearApi.BaseSanboxURL }
    
    var isAuthenticated: Bool { return true }
    
    var addionalHeader: HeaderParameter? { return nil }
    
    var defaultHeader: HeaderParameter? { return ["Accept": "application/xml", "Accept-Language": "en_US"] }
    
    var urlPath: String { return basePath + endpoint }
    
    var url: URL { return URL(string: urlPath)! }
    
    func toObservable() -> Observable<Element> {
        
        return Observable<Element>.create { (observer) -> Disposable in
            
            guard let urlRequest = try? self.asURLRequest() else {
                observer.onError(NSError.unknowError())
                return Disposables.create()
            }
            
            Alamofire
                .request(urlRequest)
                .validate(contentType: ["application/xml"])
                .response(completionHandler: { response in
                    
                    /// Validate
                    if let error = self.handleValidation(response) {
                        if error.code == 401 {
                            
                        }
                        observer.onError(error)
                        return
                    }
                    
                    /// Parse
                    do {
                        
                        guard let result = try self.decode(data: response.data!) else {
                            
                            observer.onNext(() as! Element)
                            return
                        }
                        
                        observer.onNext(result)
                        
                    } catch let error {
                        observer.onError(error)
                    }
                    observer.onCompleted()
                    return
                })
            return Disposables.create()
        }
    }
}
