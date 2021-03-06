//
//  FilterCell.swift
//  ATApp
//
//  Created by John Desjardins on 2018-04-04.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit
class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class FilterCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.forestGreen : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.darkGray
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting: Setting? {
        didSet{
            nameLabel.text = setting?.name
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "Setting"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let iconImageView: UIImageView = {
        func imageResize (image:UIImage, sizeChange:CGSize) -> UIImage{
            let hasAlpha = true
            let scale: CGFloat = 0.0 // Use scale factor of main screen
            UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
            image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            return scaledImage!
        }
        let imageView = UIImageView()
        var thumb = UIImage(named: "help")
        thumb = imageResize(image: thumb!, sizeChange: CGSize(width: 20, height: 20)).withRenderingMode(.alwaysTemplate)
        imageView.image = thumb
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews(){
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat("H:|-8-[v0(15)]-8-[v1]|", views: iconImageView, nameLabel)
        addConstraintsWithFormat("V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat("V:[v0(15)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
}
