//
//  ViewModelCoordinator.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation

public protocol ViewModelCoordinatorProtocol {
    
    var appViewModel: AppViewModelProtocol { get }
    var authenticationViewModel: AuthenticationViewModelProtocol { get }
}

public final class ViewModelCoordinator: ViewModelCoordinatorProtocol {
    
    // MARK: - View models
    public let appViewModel: AppViewModelProtocol
    public var authenticationViewModel: AuthenticationViewModelProtocol
    
    // MARK: - Init
    init(appViewModel: AppViewModelProtocol, authenticationViewModel: AuthenticationViewModelProtocol) {
        self.appViewModel = appViewModel
        self.authenticationViewModel = authenticationViewModel
    }
    
    public class func defaultGoBear() -> ViewModelCoordinator {
        
        let goBearService = GoBearService()
        
        let appViewModel = AppViewModel(goBearService: goBearService)
        let authenticationViewModel = AuthenticationViewModel()
        
        return ViewModelCoordinator(appViewModel: appViewModel, authenticationViewModel: authenticationViewModel)
    }
}
