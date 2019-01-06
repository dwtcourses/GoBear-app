//
//  UIViewController.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/6/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit

public extension UIAlertController {
    
    public class func alertWithTitle(_ title: String?, message: String?, cancelButtonTitle: String?, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: handler)
        alertViewController.addAction(cancelButton)
        return alertViewController
    }
    
    public class func alertWithTitle(_ title: String?, message: String?, cancelButtonTitle: String?) -> UIAlertController {
        return self.alertWithTitle(title, message: message, cancelButtonTitle: cancelButtonTitle, handler: nil)
    }
    
    public class func showAlertInController(_ controller: UIViewController?, alertTitle title: String?, message: String?, cancelButtonTitle: String?, handler: ((UIAlertAction) -> Void)?) {
        let alert = self.alertWithTitle(title, message: message, cancelButtonTitle: cancelButtonTitle, handler: handler)
        controller?.present(alert, animated: true, completion: nil)
    }
    
    public class func showAlertInController(_ controller: UIViewController?, alertTitle title: String?, message: String?, cancelButtonTitle: String?) {
        self.showAlertInController(controller, alertTitle: title, message: message, cancelButtonTitle: cancelButtonTitle, handler: nil)
    }
    
    public func showAlertInController(_ controller: UIViewController?) {
        controller?.present(self, animated: true, completion: nil)
    }
    
    public func show() {
        var presentedController = UIApplication.shared.keyWindow?.rootViewController
        while let viewController = presentedController?.presentedViewController {
            presentedController = viewController
        }
        
        presentedController?.present(self, animated: true, completion: nil)
    }
}
