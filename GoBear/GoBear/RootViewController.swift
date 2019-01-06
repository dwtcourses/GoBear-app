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
    fileprivate var authenViewModel: AuthenticationViewModelProtocol?
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
        viewController.authenViewModel = coordinator.authenticationViewModel
        viewController.viewModel = coordinator.appViewModel
        return viewController
    }
    
    public func binding() {
        
        authenViewModel?.output.authenticationStateDriver
            .asObservable()
            .subscribe(onNext: { (authenState) in
                self.setupContentController(authenState: authenState)
            }).disposed(by: disposeBag)
    }
    
    //    MARK:- Init
    fileprivate func setupContentController(authenState: AuthenticationState) {
        
        viewControllers = [LoginViewController.init(coordinator: coordinator!)]
//        switch authenState {
//        case .authenticated:
//            viewControllers = [LoginViewController.init(coordinator: coordinator!)]
//        case .unAuthenticated:
//            viewControllers = [WalkthroughViewController.init(coordinator: coordinator!)]
//        }
    }
}
