//
//  KeyboardObserveViewController.swift
//  GoBear
//
//  Created by Huy Nguyen on 1/6/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit
import RxCocoa
import GoBearCore

class KeyboardObserveViewController: BaseViewController {

    //    MARK:- OUTLETS
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    //    MARK:- Variables
    lazy var keyboardManager: KeyboardManager? = {
        if let _ = self.contentScrollView {
            return KeyboardManager(scrollView: self.contentScrollView)
        }
        return nil
    }()
    
    //    MARK:- View Controller Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        keyboardManager?.beginObservingKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardManager?.endObservingKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //  MARK:- Public Functions
    public func setShowUpViewBelowKeyboardBlockForActiveEditingField(_ editingField: UIView) {
        keyboardManager?.showUpViewBelowKeyboardHandler = { [weak self] keyboardHeight in
            guard let strongSelf = self else { return }
            var aRect = strongSelf.view.frame
            aRect.size.height -= UIScreen.main.bounds.height/2
            let textFieldFrame = strongSelf.contentView.convert(editingField.frame, from: editingField.superview)
            if !aRect.contains(textFieldFrame) {
                let contentOffset = CGPoint(x: 0, y: textFieldFrame.origin.y - aRect.height)
                strongSelf.contentScrollView.setContentOffset(contentOffset, animated: false)
            }
        }
    }
}

//      MARK: Private
extension KeyboardObserveViewController {
    
    fileprivate func binding() {
        
        // Touch gesture for view
        let touchGesture = UITapGestureRecognizer()
        self.view.addGestureRecognizer(touchGesture)
        
        touchGesture.rx
            .event
            .bind { recognizer in
                self.view.endEditing(true)
            }.disposed(by: disposeBag)
    }
}
