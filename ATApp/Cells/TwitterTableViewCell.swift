//
//  TwitterTableViewCell.swift
//  ATApp
//
//  Created by Janki on 2018-03-17.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class TwitterTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTwitterName: UILabel!
    
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lblTweetPostedDate: UILabel!
    @IBOutlet weak var lblTweetDescription: UILabel!
    @IBOutlet weak var lblTwitterHandle: UILabel!
    @IBOutlet weak var twitterProfileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
