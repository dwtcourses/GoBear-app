//
//  UserObjTests.swift
//  GoBearCoreTests
//
//  Created by Huy Nguyen on 1/7/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import XCTest
import RxSwift
@testable import GoBearCore

class UserObjTests: XCTestCase {
    
    fileprivate let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        super.tearDown()
        
        // Remove
        FakeGoBearCrendential.resetData()
    }
    
    func testCreateUserWithCredential() {
        
        // Given
        let goBearCrendential = FakeGoBearCrendential.valid()
        
        // When
        GoBearAuth.share.testConvertToCurrentUser(goBearCrendential)
        let savedUser = FakeGoBearCrendential.getFromDisk()
        
        // Then
        XCTAssertNotNil(savedUser, "Saved User is nil")
        XCTAssertEqual(GoBearAuth.share.currentUser?.username, savedUser?.username, "Not same Username and Password")
    }
    
    func testAuthenticationStateWithValidToken() {
        
        // Given
        let goBearCrendential = FakeGoBearCrendential.valid()
        GoBearAuth.share.convertToCurrentUser(goBearCrendential)
        
        // Then
        XCTAssertNotNil(GoBearAuth.share.currentUser, "Current User is nil")    }
    
    func testLogOut() {
        
        // Create
        FakeGoBearCrendential.makeCurrentUser()
        XCTAssertNotNil(FakeGoBearCrendential.getFromDisk())
        
        // Logout
        GoBearAuth.share.logout()
        
        // Nil
        XCTAssertNil(FakeGoBearCrendential.getFromDisk())
    }
}
