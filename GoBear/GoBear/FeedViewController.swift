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
