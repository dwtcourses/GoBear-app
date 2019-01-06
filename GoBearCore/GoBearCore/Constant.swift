//
//  Constant.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/4/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation

struct Constant {
    
    // MARK: - GoBearApp
    struct GoBearApp {
        
        static let ApplicationId = ""
    }
    
    // MARK: - GoBearApi
    struct GoBearApi {
        
        static let BaseSanboxURL = ""
    }
    
    // MARK: - Object
    struct Object {
        
        static let CreateAt = "createAt"
        static let UpdateAt = "updateAt"
        
        // MARK: - User
        struct User {
            
            static let Username = "username"
            static let Password = "password"
            static let IsRemember = "isRemember"
            
            static let UsernameValue = "GoBear"
            static let PasswordValue = "GoBearDemo"
        }
        
        // MARK: - Product
        struct Product {
            
            static let Item = "item"
            
            static let Title = "title"
            static let PublicDate = "pubDate"
            static let Thumbnail = "thumbnail"
            static let Description = "description"
        }
    }
    
    // MARK: - ErrorMessage
    struct Error {
        
        static let Domain = "com.gb.gobear.defaultErrorDomain"
        
        struct Code {
            
            static let Default = 999
        }
        
        struct Message {
            
            // MARK: - Login
            struct Login {
                
                // MARK: - Username
                struct Username {
                    
                    static let Empty = "Please insert username field"
                    static let Size = "Username too short"
                    static let ContainSpecChar = "Only use letters, numbers and '_'"
                }
                
                // MARK: - Password
                struct Password {
                    
                    static let Empty = "Please insert password field"
                    static let Size = "8 or more characters"
                    static let UpperAndLowerCase = "At least a Upper & lowercase letters"
                    static let IncludeNumber = "At least one number"
                }
                
                static let IncorrectUser = "Username or password not correct"
            }
        }
    }
}
