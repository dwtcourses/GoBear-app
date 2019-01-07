//
//  FakeGoBearCredential.swift
//  GoBearCoreTests
//
//  Created by Huy Nguyen on 1/7/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import XCTest
@testable import GoBearCore

class FakeGoBearCrendential {
    
    class func valid() -> UserObj {
        let goBearUser = UserObj.defaultUser()
        goBearUser.isRememberMe = true
        return goBearUser
    }
    
    class func invalid() -> UserObj {
        let goBearUser = UserObj.defaultUser()
        return goBearUser
    }
    
    class func getFromDisk() -> UserObj? {
        
        guard let data = UserDefaults.standard.data(forKey: "GoBear.CurrentUser") else { return nil }
        guard let userObj = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserObj else { return nil }
        
        return userObj
    }
    
    class func resetData() {
        GoBearAuth.share.logout()
    }
    
    class func makeCurrentUser() {
        let goBearCrendential = FakeGoBearCrendential.valid()
        GoBearAuth.share.testConvertToCurrentUser(goBearCrendential)
    }
}
