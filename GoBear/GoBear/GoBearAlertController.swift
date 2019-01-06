//
//  GoBearAlertController.swift
//  GoBear
//
//  Created by Huy Nguyen on 1/6/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit

class GoBearAlertController: UIAlertController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.tintColor = UIColor.orange
    }
    
    class func initWithTitle(title: String?, message: String?, preferredStyle: UIAlertController.Style) -> GoBearAlertController {
        let alertController = GoBearAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.view.backgroundColor = UIColor.gray
        alertController.view.layer.cornerRadius = 20
        
        if let title = title {
            let attributedTitleString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),
                                                                                       NSAttributedString.Key.foregroundColor : UIColor.black])
            alertController.setValue(attributedTitleString, forKey: "attributedTitle")
        }
        
        if let message = message {
            let attributedMessageString = NSMutableAttributedString(string: message, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12),
                                                                                                  NSAttributedString.Key.foregroundColor : UIColor.darkGray])
            alertController.setValue(attributedMessageString, forKey: "attributedMessage")
        }
        return alertController
    }
}

