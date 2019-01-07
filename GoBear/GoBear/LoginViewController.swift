//
//  LoginViewController.swift
//  GoBear
//
//  Created by Huy Nguyen on 1/6/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit
import RxCocoa
import GoBearCore

class LoginViewController: KeyboardObserveViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var txfUsername: GoBearTextField!
    @IBOutlet weak var txfPassword: GoBearTextField!
    @IBOutlet weak var swiRememberMe: UISwitch!
    @IBOutlet weak var btnLogin: GoBearButton!
    
    // MARK:- Variable
    fileprivate var coordinator: ViewModelCoordinatorProtocol!
    fileprivate var viewModel: AuthenticationViewModelProtocol!
    
    // MARK:- View Controller Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.binding()
        self.callbacks()
    }
    
    /// Init
    ///
    /// - Parameter coordinator: View model coordinator
    /// - Returns: self view controller
    class func `init`(coordinator: ViewModelCoordinatorProtocol) -> LoginViewController {
        let viewController = LoginViewController.fromStoryboard(Constant.Storyboard.Authentication) as! LoginViewController
        viewController.coordinator = coordinator
        viewController.viewModel = coordinator.authenticationViewModel
        return viewController
    }
    
    fileprivate func binding() {
        
        swiRememberMe.rx.value.bind(to: viewModel.input.isRememberBool).disposed(by: disposeBag)
        txfUsername.rx.text.bind(to: viewModel.input.usernameTxfString).disposed(by: disposeBag)
        txfPassword.rx.text.bind(to: viewModel.input.passwordTxfString).disposed(by: disposeBag)
        btnLogin.rx.tap.bind(to: viewModel.input.loginButtonOnTapPublish).disposed(by: disposeBag)
    }
    
    fileprivate func callbacks() {
        
        viewModel.output
            .isSuccess
            .asObservable()
            .bind { isSuccess in
                if isSuccess {
                    self.navigateToFeed()
                }
            }.disposed(by: disposeBag)
        
        viewModel.output
            .errorMessage
            .asObservable()
            .bind { errorMessage in
                guard let errorMessage = errorMessage else {
                    return
                }
                AlertManager.nativeAlertWithTitle("Error", message: "\(errorMessage)", cancelButtonTitle: "OK", handler: nil).showAlertInController(self)
            }.disposed(by: disposeBag)
    }
    
    fileprivate func navigateToFeed() {
        let viewController = FeedViewController.init(coordinator: coordinator)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
