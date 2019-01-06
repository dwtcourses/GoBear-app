//
//  GoBearService.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import RxSwift

public final class GoBearService {
    
    public func availableProductsObserver() -> Observable<[ProductObj]> {
        return GoBearProductsRequest().toObservable()
    }
}
