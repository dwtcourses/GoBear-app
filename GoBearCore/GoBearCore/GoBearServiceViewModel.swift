//
//  GoBearServiceViewModel.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/6/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Protocol
public protocol GoBearServiceViewModelProtocol {
    
    var input: GoBearServiceViewModelInput { get }
    var output: GoBearServiceViewModelOutput { get }
}

public protocol GoBearServiceViewModelInput {
    
    var startFetchProductPublisher: PublishSubject<Bool> { get }
}

public protocol GoBearServiceViewModelOutput {
    
    var listProductVariable: Variable<[ProductObj]> { get }
}

// MARK: - View model
public final class GoBearServiceViewModel: GoBearServiceViewModelProtocol,
    GoBearServiceViewModelInput,
GoBearServiceViewModelOutput {
    
    // MARK: - Protocol
    public var input: GoBearServiceViewModelInput { return self }
    public var output: GoBearServiceViewModelOutput { return self }
    
    // MARK: - Input
    public var startFetchProductPublisher = PublishSubject<Bool>()
    
    // MARK: - Output
    public var listProductVariable = Variable<[ProductObj]>([])
    
    // MARK: - Variable
    fileprivate var goBearService: GoBearService
    fileprivate let disposeBag = DisposeBag()
    
    public init(goBearService: GoBearService) {
        self.goBearService = goBearService
        
        startFetchProductPublisher
            .asObserver()
            .distinctUntilChanged()
            .subscribe(onNext: {(trigger) in
                if trigger {
                    _ = goBearService.availableProductsObserver()
                        .bind(onNext: { (products) in
                            self.listProductVariable.value = products
                        })
                }
            })
            .disposed(by: disposeBag)
    }
}
