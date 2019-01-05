//
//  GoBearAuth.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/4/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import RxSwift

public class GoBearAuth {

    // MARK: - Variable
    public var loginPublisher = PublishSubject<Void>()
    fileprivate let disposeBag = DisposeBag()
    
    // MARK: - Share
    public static let share = GoBearAuth()
    
    // MARK: - Persistant Store
    fileprivate let persistantStore = UserDefaults.standard
    fileprivate static let PersistantStoreKey = "GoBear.CurrentUser"
    
    // MARK : - Current User
    public fileprivate(set) var currentUserVariable = Variable<UserObj?>(nil)
    public var currentUser: UserObj? { return currentUserVariable.value }
    public var authenticationState: Observable<AuthenticationState>
    
    // Lock
    fileprivate let lock = NSLock()
    fileprivate let storeLock = NSLock()
    
    public init() {
        
        authenticationState = currentUserVariable.asObservable()
            .map { $0 == nil ? .unAuthenticated : .authenticated }
            .distinctUntilChanged()
        
        // Load disk
        loadPersistantUser()
        
        currentUserVariable.asObservable()
            .subscribe(onNext: { [unowned self] (userObj) in
                self.savePersistantUser(userObj)
            }).disposed(by: disposeBag)
        
        
    }
}

extension GoBearAuth {
    
    fileprivate func loadPersistantUser() {
        
        // Lock
        lock.lock()
        defer {
            self.lock.unlock()
        }
        
        guard let data = UserDefaults.standard.data(forKey: GoBearAuth.PersistantStoreKey) else {
            return
        }
        
        guard let userObj = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UserObj.self, from: data) else {
            return
        }
        currentUserVariable.value = userObj
    }
    
    fileprivate func savePersistantUser(_ userObj: UserObj?) {
        if let userObj = userObj {
            
            // Lock
            storeLock.lock()
            defer {
                self.storeLock.unlock()
            }
            
            let data = try? NSKeyedArchiver.archivedData(withRootObject: userObj, requiringSecureCoding: true)
            persistantStore.set(data, forKey: GoBearAuth.PersistantStoreKey)
            persistantStore.synchronize()
        } else {
            
            // Lock
            storeLock.lock()
            defer {
                self.storeLock.unlock()
            }
            
            // Remove
            persistantStore.removeObject(forKey: GoBearAuth.PersistantStoreKey)
            persistantStore.synchronize()
        }
    }
}
