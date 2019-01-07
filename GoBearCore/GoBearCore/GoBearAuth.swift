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
    public var usernameFieldViewModel = GoBearUsernameField()
    public var passwordFieldViewModel = GoBearPasswordField()
    public var loginPublisher = PublishSubject<Void>()
    public var isSuccess = Variable<Bool>(false)
    public var errorVariable = Variable<String?>(nil)
    public var usernameVariable = Variable<String?>(nil)
    public var passwordVariable = Variable<String?>(nil)
    public var isRememberVariable = Variable<Bool>(false)
    
    fileprivate let disposeBag = DisposeBag()
    
    // MARK: - Share
    public static let share = GoBearAuth()
    
    // MARK: - Persistant Store
    fileprivate let persistantStore = UserDefaults.standard
    fileprivate static let PersistantStoreKey = "GoBear.CurrentUser"
    
    // MARK : - Current User
    public fileprivate(set) var currentUserVariable = Variable<UserObj?>(nil)
    public var currentUser: UserObj? { return currentUserVariable.value }
    public var authenStateObj: Observable<AuthenticationState?>
    
    // Lock
    fileprivate let lock = NSLock()
    fileprivate let storeLock = NSLock()
    
    public init() {
        
        authenStateObj = currentUserVariable.asObservable()
            .map { $0 == nil || $0?.isRemember == false ? .unAuthenticated : .authenticated }
            .distinctUntilChanged()
        
        // Load disk
        loadPersistantStoreUser()
        
        currentUserVariable.asObservable()
            .subscribe(onNext: { [unowned self] (userObj) in
                self.savePersistantUser(userObj)
            }).disposed(by: disposeBag)
        
        _ = usernameVariable.asObservable()
            .subscribe { (emailValue) in
                guard let value = emailValue.element else { return }
                self.usernameFieldViewModel.textString = Variable(value)
        }
        
        _ = passwordVariable.asObservable()
            .subscribe { (phoneValue) in
                guard let value = phoneValue.element else { return }
                self.passwordFieldViewModel.textString = Variable(value)
        }
        
        loginPublisher.asObserver()
            .flatMapLatest{ [unowned self] _ -> Observable<UserObj?> in
                return self.requestOauthWithGoBear()
            }.subscribe(onNext: { (userObj) in
                guard let userObj = userObj else {
                    self.updateErrorMessage()
                    return
                }
                self.convertToCurrentUser(userObj)
                
            }).disposed(by: disposeBag)
    }
}

// MARK: - Private
extension GoBearAuth {
    
    fileprivate func requestOauthWithGoBear() -> Observable<UserObj?> {
        return Observable<UserObj?>.create {[unowned self] (observer) -> Disposable in
            
            guard self.usernameFieldViewModel.validate() && self.passwordFieldViewModel.validate() else {
                observer.onNext(nil)
                observer.onCompleted()
                return Disposables.create()
            }
            
            let username = self.usernameFieldViewModel.textString.value!
            let password = self.passwordFieldViewModel.textString.value!
            
            guard username == Constant.Object.User.UsernameValue && password == Constant.Object.User.PasswordValue else {
                observer.onNext(nil)
                observer.onCompleted()
                return Disposables.create()
            }
            
            let userObj = UserObj(username: username,
                                  password: password,
                                  isRemember: self.isRememberVariable.value)
            
            observer.onNext(userObj)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    fileprivate func updateErrorMessage() {
        
        if let usernameErrMessage = self.usernameFieldViewModel.errorValue.value {
            self.errorVariable.value = usernameErrMessage
            return
        }
        
        if let pwdErrorMessage = self.passwordFieldViewModel.errorValue.value {
            self.errorVariable.value = pwdErrorMessage
            return
        }
        
        let username = self.usernameFieldViewModel.textString.value!
        let password = self.passwordFieldViewModel.textString.value!
        
        guard username == Constant.Object.User.UsernameValue && password == Constant.Object.User.PasswordValue else {
            self.errorVariable.value = Constant.Error.Message.Login.IncorrectUser
            return
        }
        
        self.isSuccess.value = true
    }
}

// MARK: - Authentication
extension GoBearAuth {
    
    fileprivate func loadPersistantStoreUser() {
        
        // Lock
        lock.lock()
        defer {
            self.lock.unlock()
        }
        
        guard let data = persistantStore.data(forKey: GoBearAuth.PersistantStoreKey) else {
            return
        }
        
        guard let userObj = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserObj else {
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
            
            guard userObj.isRemember else {
                return
            }
            
            let data = NSKeyedArchiver.archivedData(withRootObject: userObj)
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
    
    public func convertToCurrentUser(_ userObj: UserObj) {
        
        self.isSuccess.value = true
        currentUserVariable.value = userObj
    }
    
    public func logout() {
        
        // Lock
        lock.lock()
        defer {
            self.lock.unlock()
        }
        
        savePersistantUser(nil)
        isSuccess.value = false
        currentUserVariable.value = nil
    }
}
