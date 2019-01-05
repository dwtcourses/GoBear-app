//
//  RootViewController.swift
//  GoBear
//
//  Created by Huy Nguyen on 1/4/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit
import RxSwift
import GoBearCore

class RootViewController: UINavigationController {
    
    //    MARK:- Variables
    fileprivate var viewModel: AppViewModelProtocol?
    //    fileprivate var authenViewModel: AuthenticateViewModelProtocol?
    fileprivate var coordinator: ViewModelCoordinatorProtocol!
    
    fileprivate lazy var disposeBag = DisposeBag()
    
    //    MARK:- View Controller Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Init
    ///
    /// - Parameter coordinator: View model coordinator app flow
    /// - Returns: Root view controller
    class func `init`(coordinator: ViewModelCoordinatorProtocol) -> RootViewController {
        let viewController = RootViewController.fromStoryboard(Constant.Storyboard.Main) as! RootViewController
        viewController.coordinator = coordinator
        //        authenViewModel = coordinator.authenViewModel
        viewController.viewModel = coordinator.appViewModel
        return viewController
    }
    
    public func binding() {
        
        viewModel?.output.applicationStateVariable
            .asObservable()
            .subscribe(onNext: { (applicationState) in
                self.setupContentController(appState: applicationState)
            }).disposed(by: disposeBag)
    }
    
    //    MARK:- Init
    fileprivate func setupContentController(appState: ApplicationState, authenState: AuthenticationState? = nil) {
        switch appState {
        case .firstTime:
            viewControllers = [WalkthroughViewController.init(coordinator: coordinator!)]
        case .authenticate:
            switch authenState! {
            case .authenticated:
                viewControllers = [WalkthroughViewController.init(coordinator: coordinator!)]
            case .unAuthenticated:
                viewControllers = [WalkthroughViewController.init(coordinator: coordinator!)]
            }
        }
    }
}
