//
//  InstagramTableViewCell.swift
//  ATApp
//
//  Created by Janki on 2018-03-17.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class InstagramTableViewCell: UITableViewCell {
    @IBOutlet weak var btnLike: UIButton!
    
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var instaFeedPostedDate: UILabel!
    @IBOutlet weak var instaFeedImage: UIImageView!
    @IBOutlet weak var instaFeedDescription: UILabel!
    @IBOutlet weak var instaUserName: UILabel!
    @IBOutlet weak var instaDisplayName: UILabel!
    @IBOutlet weak var instaProfileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
