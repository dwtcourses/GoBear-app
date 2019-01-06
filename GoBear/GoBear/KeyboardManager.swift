//
//  KeyboardManager.swift
//  GoBear
//
//  Created by Huy Nguyen on 1/6/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit

class KeyboardManager {
    
    weak var scrollView: UIScrollView?
    var showUpViewBelowKeyboardHandler: ((CGFloat)->Void)?
    
    init(scrollView: UIScrollView?) {
        self.scrollView = scrollView
    }
    
    func beginObservingKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func endObservingKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc internal dynamic func keyboardWillShow(_ note: Notification) {
        guard let scrollView = scrollView, let userInfo = note.userInfo else {
            return
        }
        let keyboardRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: 0, bottom: keyboardRect!.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        if let safeClosure = showUpViewBelowKeyboardHandler {
            safeClosure(keyboardRect!.height)
        }
    }
    
    @objc internal dynamic func keyboardWillHide(_ note: Notification) {
        guard let scrollView = scrollView else {
            return
        }
        let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: 0, bottom: 0, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}
