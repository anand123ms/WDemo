//
//  TableViewCell.swift
//  WDemo
//
//  Created by Atul Mane on 14/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var feed:Feed! {
        didSet {
            self.titleLabel.text = feed.title
            self.descriptionLabel.text = feed.description
            self.iconImage.kf.setImage(with: URL(string: feed.enclosure?.url ?? ""))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
