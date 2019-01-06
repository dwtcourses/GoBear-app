//
//  AlertManager.swift
//  GoBear
//
//  Created by Huy Nguyen on 1/6/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit
import GoBearCore
import RxSwift

class AlertManager {
    
    static let disposeBag = DisposeBag()
    
    class func nativeAlertWithTitle(_ title : String?, message: String?, cancelButtonTitle: String?,
                                    handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        
        let alertViewController = GoBearAlertController.initWithTitle(title: title ?? "", message: message, preferredStyle: UIAlertController.Style.alert)
        alertViewController.modalPresentationStyle = .currentContext
        if let cancelButtonTitle = cancelButtonTitle {
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: UIAlertAction.Style.default, handler: handler)
            alertViewController.addAction(cancelAction)
        }
        return alertViewController
    }
    
    class func showActionSheet(_ actions: [UIAlertAction], title: String? = nil, message: String? = nil,
                               cancelButtonTitle: String = "Cancel", inViewController viewController: UIViewController?, fromSender sender: UIView) {
        
        guard let viewController = viewController else {
            return
        }
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertViewController.modalPresentationStyle = .currentContext
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: UIAlertAction.Style.cancel, handler: nil)
        alertViewController.addAction(cancelAction)
        
        actions.forEach { action in
            alertViewController.addAction(action)
        }
        
        let popPresenter = alertViewController.popoverPresentationController
        popPresenter?.sourceView = sender
        popPresenter?.sourceRect = sender.bounds
        
        viewController.present(alertViewController, animated: true, completion: nil)
    }
}

