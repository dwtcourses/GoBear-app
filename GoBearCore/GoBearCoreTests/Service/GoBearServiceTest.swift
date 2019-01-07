//
//  GoBearServiceTest.swift
//  GoBearCoreTests
//
//  Created by Huy Nguyen on 1/7/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import XCTest
import RxSwift
import Alamofire
@testable import GoBearCore

class GoBearServiceTest: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }
    
    func testAvailableProductsObserver() {
        
        // When
        let promise = expectation(description: "testAvailableProductsObserver")
        
        // Then
        GoBearService().availableProductsObserver()
            .subscribe(onNext: { products in
                if products.count == 0 {
                    XCTFail("None available product at testAvailableProductsObserver")
                }
                promise.fulfill()
            }, onError: { error in
                XCTFail(error.localizedDescription)
            }).disposed(by: disposeBag)
        
        // Expect
        waitForExpectations(timeout: 10, handler: nil)
    }
}
