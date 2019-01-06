//
//  AuthenticationViewModel.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/6/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Protocol
public protocol AuthenticationViewModelProtocol {
    
    var input: AuthenticationViewModelInput { get }
    var output: AuthenticationViewModelOutput { get }
}

public protocol AuthenticationViewModelInput {
    
    var usernameTxfString: Variable<String?> { get }
    var passwordTxfString: Variable<String?> { get }
    var isRememberBool: Variable<Bool> { get }
    var loginButtonOnTapPublish: PublishSubject<Void> { get }
}

public protocol AuthenticationViewModelOutput {
    
    var authenticationStateDriver: Driver<AuthenticationState> { get }
    var isSuccess: Variable<Bool> { get }
    var errorMessage: Variable<String?> { get }
}

// MARK: - View model
public final class AuthenticationViewModel: AuthenticationViewModelProtocol,
                                            AuthenticationViewModelInput,
                                            AuthenticationViewModelOutput {
    
    // MARK: - Protocol
    public var input: AuthenticationViewModelInput { return self }
    public var output: AuthenticationViewModelOutput { return self }
    
    // MARK: - Variable
    fileprivate let goBearAuth = GoBearAuth.share
    
    // MARK: - Input Protocol
    public var loginButtonOnTapPublish: PublishSubject<Void> { return GoBearAuth.share.loginPublisher }
    public var usernameTxfString: Variable<String?> { return GoBearAuth.share.usernameVariable }
    public var passwordTxfString: Variable<String?> { return GoBearAuth.share.passwordVariable }
    public var isRememberBool: Variable<Bool> { return GoBearAuth.share.isRememberVariable }
    
    // MARK: - Output Protocol
    public var authenticationStateDriver: Driver<AuthenticationState>
    public var isSuccess: Variable<Bool> { return GoBearAuth.share.isSuccess }
    public var errorMessage: Variable<String?> { return GoBearAuth.share.errorVariable }
    
    // MARK: - Init
    public init() {
        
        let authenticateChanged = GoBearAuth.share.authenStateObj
        authenticationStateDriver = authenticateChanged.asDriver(onErrorJustReturn: AuthenticationState.unAuthenticated)
    }
}
