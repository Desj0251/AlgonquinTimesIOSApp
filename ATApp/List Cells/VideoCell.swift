//
//  VideoCell.swift
//  ATApp
//
//  Created by John Desjardins on 2018-04-06.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import Foundation

class videoCell: BaseCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.rgb(193, 205, 193) : UIColor.white
        }
    }
    
    var article: [String: Any]? {
        didSet {
            
            let title = article!["title"] as? [String: Any]
            let titleRendered = title?["rendered"] as? String
            let cleanTitle = cleanTheTitle(title: titleRendered!)
            titleLabel.text = cleanTitle
            
            if let testtitle = cleanTitle as? String {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: testtitle).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16.0)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
            
            let embedded = article!["_embedded"] as? [String: Any]
            let author = embedded!["author"] as? [[String: Any]]
            let authorName = author![0]["name"] as? String
            let string = article?["date"] as? String
            
            let authorImages = author![0]["avatar_urls"] as? [String: Any]
            
            if let authorImg = authorImages!["48"] as? String {
                let url = URL(string: authorImg)
                if let imageFromCache = imageCache.object(forKey: authorImg as AnyObject) as? UIImage {
                    userProfileImageView.image = imageFromCache
                } else {
                    DispatchQueue.main.async {
                        let data = try? Data(contentsOf: url!)
                        let articleimage = UIImage(data: data!)
                        imageCache.setObject(articleimage!, forKey: authorImg as AnyObject)
                        self.userProfileImageView.image = articleimage
                    }
                }
            } else {
                userProfileImageView.image = UIImage(named: "atlogowhite")
            }
            
            let dateFormatter = DateFormatter()
            let tempLocale = dateFormatter.locale // save locale temporarily
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: string!)!
            dateFormatter.dateFormat = "MMMM d, yyyy"
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            
            subtitleLabel.text = "\(authorName!) - \(String(describing: dateString))"
            
            if let media = embedded!["wp:featuredmedia"] as? [[String: Any]] {
                let mediaDetails = media[0]["media_details"] as? [String: Any]
                let sizes = mediaDetails!["sizes"] as? [String: Any]
                let large = sizes!["medium"] as? [String: Any]
                let imageUrl = large!["source_url"] as? String
                let url = URL(string: imageUrl!)
                
                if let imageFromCache = imageCache.object(forKey: imageUrl as AnyObject) as? UIImage
                {
                    thumbnailImageView.image = imageFromCache
                } else {
                    DispatchQueue.main.async {
                        let data = try? Data(contentsOf: url!)
                        let articleimage = UIImage(data: data!)
                        imageCache.setObject(articleimage!, forKey: imageUrl as AnyObject)
                        self.thumbnailImageView.image = articleimage
                    }
                }
            }  else {
                thumbnailImageView.image = UIImage(named: "image-not-found")
            }
            
        }
    }
    
    func cleanTheTitle(title: String) -> String {
        return title.replacingOccurrences(of: "&#8211;", with: "-", options: .literal, range: nil).replacingOccurrences(of: "&#038;", with: "&", options: .literal, range: nil).replacingOccurrences(of: "&#8217;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&#8216;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&#233;", with: "é", options: .literal, range: nil).replacingOccurrences(of: "&#8230;", with: "...", options: .literal, range: nil).replacingOccurrences(of: "&#8212;", with: "--", options: .literal, range: nil)
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "taylor_swift_bad_blood")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        // imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255,alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.numberOfLines = 2
        //label.textColor = UIColor.forestGreen
        return label
    }()
    let subtitleLabel: UITextView = {
        let label = UITextView()
        label.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        label.textColor = UIColor.gray
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(seperatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)
        
        // Vertical Contraints
        addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, seperatorView)
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: seperatorView)
        
        // Top Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        // Left Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        // Right Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        // Height Constraint
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraint!)
        
        // Top Constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        // Left Constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        // Right Constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        // Height Constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implimented")
    }
}
