//
//  FacebookTableViewCell.swift
//  ATApp
//
//  Created by Janki on 2018-03-17.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class FacebookTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var imgViewFeed: UIImageView!
    @IBOutlet weak var lblFeedDescription: UILabel!
    @IBOutlet weak var lblPostedDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
