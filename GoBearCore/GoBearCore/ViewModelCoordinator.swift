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
}

public final class ViewModelCoordinator: ViewModelCoordinatorProtocol {
    
    // MARK: - View models
    public let appViewModel: AppViewModelProtocol
    
    // MARK: - Init
    init(appViewModel: AppViewModelProtocol) {
        self.appViewModel = appViewModel
    }
    
    public class func defaultGoBear() -> ViewModelCoordinator {
        
        let goBearService = GoBearService()
        
        let appViewModel = AppViewModel(goBearService: goBearService)
        
        return ViewModelCoordinator(appViewModel: appViewModel)
    }
}
