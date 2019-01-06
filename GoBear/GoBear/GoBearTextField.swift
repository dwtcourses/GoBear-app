//
//  GoBearTextField.swift
//  GoBear
//
//  Created by Huy Nguyen on 1/6/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit

class GoBearTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initCommon()
    }
    
    fileprivate func initCommon() {
        self.addLineToView(view: self, color: .darkGray, width: 0.5)
    }
    
    func addLineToView(view : UIView, color: UIColor, width: Double) {
        
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|",
                                                           options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|",
                                                           options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
    }
}
