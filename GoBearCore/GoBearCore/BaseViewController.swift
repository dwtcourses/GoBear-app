//
//  BaseViewController.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/4/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit
import RxSwift

open class BaseViewController: UIViewController {
    
    public let disposeBag = DisposeBag()

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
