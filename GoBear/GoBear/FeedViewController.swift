//
//  FeedViewController.swift
//  GoBear
//
//  Created by Huy Nguyen on 1/6/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit
import GoBearCore

class FeedViewController: BaseViewController {
    
    // MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variable
    fileprivate var coordinator: ViewModelCoordinatorProtocol!
    fileprivate var viewModel: GoBearServiceViewModelProtocol!
    fileprivate var products = [ProductObj]()
    
    // MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.binding()
    }
    
    class func `init`(coordinator: ViewModelCoordinatorProtocol) -> FeedViewController {
        let viewController = FeedViewController.fromStoryboard(Constant.Storyboard.Feed) as! FeedViewController
        viewController.coordinator = coordinator
        viewController.viewModel = coordinator.goBearServiceViewModel
        return viewController
    }
    
    fileprivate func setupUI() {
        
        self.tableView.registerCell(FeedCell.self)
    }
    
    fileprivate func binding() {
        
        viewModel.input.startFetchProductPublisher.onNext(true)
        
        viewModel.output.listProductVariable
            .asObservable()
            .subscribe(onNext: { (products) in
                self.products = products
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    @IBAction func pressedLogoutButton(_ sender: UIButton) {
        GoBearAuth.share.logout()
        
        self.navigationController?.viewControllers.removeAll()
        
        let rootViewController = RootViewController.init(coordinator: coordinator)
        rootViewController.binding()
        
        let window = UIApplication.shared.delegate?.window
        
        window??.makeKeyAndVisible()
        window??.rootViewController = rootViewController
        
    }
}

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        cell.configure(products[indexPath.row])
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = FeedDetailViewController.init(coordinator: coordinator)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
