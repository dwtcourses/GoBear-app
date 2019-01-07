//
//  GoBearCoreTests.swift
//  GoBearCoreTests
//
//  Created by Huy Nguyen on 1/4/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import XCTest
@testable import GoBearCore

class GoBearCoreTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRegexUsername() {
        
        // When
        let promise = expectation(description: "testRegexUsername")
        
        // Then
        let usernameField = GoBearUsernameField()
        
        self.lazyInitUsername().forEach {
            usernameField.textString.value = $0
            if !usernameField.validate() {
                print("The value is error: \(usernameField.errorValue.value ?? "")")
            }
        }
        
        promise.fulfill()
        
        // Expect
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testRegexPassword() {
        
        // When
        let promise = expectation(description: "testRegexPassword")
        
        // Then
        let passwordField = GoBearPasswordField()
        
        self.lazyInitPassword().forEach {
            passwordField.textString.value = $0
            if !passwordField.validate() {
                print("The value is error: \(passwordField.errorValue.value ?? "")")
            }
        }
        
        promise.fulfill()
        // Expect
        waitForExpectations(timeout: 10, handler: nil)
    }
}

// MARK: - fileprivate
extension GoBearCoreTests {
    
    fileprivate func lazyInitUsername() -> [String] {
        return ["nil", "", "aaaaaabc", "ccCDddEF", "ghjIKNMM+-!)", "GoBearD"]
    }
    
    fileprivate func lazyInitPassword() -> [String] {
        return ["", "aaaaaaaa", "Pass", "Passw0rd1!@#", "GeneralTso", "aA@1aaaa", "aA@1aaaaasfljs;lkfe"]
    }
}
