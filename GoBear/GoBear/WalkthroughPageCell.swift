//
//  WalkthroughPageCell.swift
//  GoBear
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit

class WalkthroughPageCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var lblContent: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    /// Configure
    ///
    /// - Parameter value: text value
    func configure(_ value: String) {
        lblContent.text = value
    }
}
