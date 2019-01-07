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
    fileprivate var coordinator: ViewModelCoordinatorProtocol!
    
    fileprivate lazy var disposeBag = DisposeBag()
    
    //    MARK:- View Controller Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [WalkthroughViewController.init(coordinator: coordinator)]
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
        viewController.viewModel = coordinator.appViewModel
        return viewController
    }
    
    public func binding() { }
}
