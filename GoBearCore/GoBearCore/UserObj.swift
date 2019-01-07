//
//  UserObj.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/4/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import RxSwift

public final class UserObj: NSObject, NSCoding {
    
    // MARK: - Variable
    public private(set) var username: String
    public private(set) var password: String
    public private(set) var isRemember: Bool
    
    public init(username: String, password: String, isRemember: Bool) {
        self.username = username
        self.password = password
        self.isRemember = isRemember
    }
    
    @objc required public init?(coder aDecoder: NSCoder) {
        username = aDecoder.decodeObject(forKey: Constant.Object.User.Username) as! String
        password = aDecoder.decodeObject(forKey: Constant.Object.User.Password) as! String
        isRemember = aDecoder.decodeBool(forKey: Constant.Object.User.IsRemember)
        super.init()
    }
    
    @objc public func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: Constant.Object.User.Username)
        aCoder.encode(password, forKey: Constant.Object.User.Password)
        aCoder.encode(isRemember, forKey: Constant.Object.User.IsRemember)
    }

    class func defaultUser() -> UserObj {
        let user = UserObj(username: Constant.Object.User.UsernameValue, password: Constant.Object.User.PasswordValue, isRemember: false)
        return user
    }
}
