//
//  AuthenticationViewController.swift
//  GoBear
//
//  Created by Huy Nguyen on 1/6/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit
import GoBearCore

class AuthenticationViewController: KeyboardObserveViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var txfUsername: GoBearTextField!
    @IBOutlet weak var txfPassword: GoBearTextField!
    @IBOutlet weak var swiRememberMe: UISwitch!

    // MARK:- Variable
    fileprivate var coordinator: ViewModelCoordinatorProtocol!
    
    // MARK:- View Controller Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Init
    ///
    /// - Parameter coordinator: View model coordinator
    /// - Returns: self view controller
    class func `init`(coordinator: ViewModelCoordinator) -> AuthenticationViewController {
        let viewController = AuthenticationViewController.fromStoryboard(Constant.Storyboard.Authentication) as! AuthenticationViewController
        viewController.coordinator = coordinator
        return viewController
    }
    
    func binding() {
        
    }
}
