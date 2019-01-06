//
//  FeedCell.swift
//  GoBear
//
//  Created by Huy Nguyen on 1/6/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit
import GoBearCore
import SDWebImage

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ product: ProductObj) {
        
        lblTitle.text = product.title
        lblDate.text = product.pubDate
        lblDescription.text = product.description
        
        guard let imageURL = product.thumbnail else {
            return
        }
        thumbnail.sd_setImage(with: URL(string: imageURL), completed: nil)
    }
}
