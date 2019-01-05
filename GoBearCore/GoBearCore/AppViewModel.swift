//
//  AppViewModel.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/4/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol
public protocol AppViewModelProtocol {
    
    var input: AppViewModelInput { get }
    var output: AppViewModelOutput { get }
}

public protocol AppViewModelInput {
    
    var walkthroughScreenPublish: PublishSubject<Void> { get }
}

public protocol AppViewModelOutput {
    
    var applicationStateVariable: Variable<ApplicationState> { get }
}

public final class AppViewModel: AppViewModelInput, AppViewModelOutput, AppViewModelProtocol {
    
    // MARK: - View model
    public var input: AppViewModelInput { return self }
    public var output: AppViewModelOutput { return self }
    
    // MARK: - Variable
    public var walkthroughScreenPublish: PublishSubject<Void> = PublishSubject<Void>()
    public var applicationStateVariable: Variable<ApplicationState> = Variable<ApplicationState>(.firstTimeCome)
    
    // MARK: - Init
    public init () {
        
        
    }
}
