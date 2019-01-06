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
    
    // MARK:- OUTLETs
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func setupUI() {
        
        self.tableView.registerCell(FeedCell.self)
    }
}

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        cell.configure(<#T##product: ProductObj##ProductObj#>)
        return cell
    }
}
