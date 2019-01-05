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
    public private(set) var username: String?
    public private(set) var isRemember: Bool?
    
    @objc required public init?(coder aDecoder: NSCoder) {
        username = aDecoder.decodeObject(forKey: Constant.Object.User.Username) as? String
        isRemember = aDecoder.decodeObject(forKey: Constant.Object.User.IsRemember) as? Bool
        super.init()
    }
    
    @objc public func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: Constant.Object.User.Username)
        aCoder.encode(isRemember, forKey: Constant.Object.User.IsRemember)
    }

}
