//
//  GoBearButton.swift
//  GoBear
//
//  Created by Huy Nguyen on 1/6/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit

class GoBearButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Common
        self.initCommon()
    }
    
    fileprivate func initCommon() {
        
        layer.masksToBounds = true
        layer.cornerRadius = 8.0
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 0.5
    }
}
