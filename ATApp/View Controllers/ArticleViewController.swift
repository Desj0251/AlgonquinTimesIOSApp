//
//  ArticleViewController.swift
//  ATApp
//
//  Created by John Desjardins on 2018-03-26.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    var article: [String: Any]? {
        didSet{
            if let embedded = article!["_embedded"] as? [String: Any] {
                let author = embedded["author"] as? [[String: Any]]
            
                if let media = embedded["wp:featuredmedia"] as? [[String: Any]] {
                    let mediaDetails = media[0]["media_details"] as? [String: Any]
                    let sizes = mediaDetails!["sizes"] as? [String: Any]
                    let large = sizes!["medium"] as? [String: Any]
                    let imageUrl = large!["source_url"] as? String
                    let url = URL(string: imageUrl!)
                    
                    if let imageFromCache = imageCache.object(forKey: imageUrl as AnyObject) as? UIImage
                    {
                        self.imageView.image = imageFromCache
                    } else {
                        DispatchQueue.main.async {
                            let data = try? Data(contentsOf: url!)
                            let articleimage = UIImage(data: data!)
                            imageCache.setObject(articleimage!, forKey: imageUrl as AnyObject)
                            self.imageView.image = articleimage
                        }
                    }
                } else {
                    self.imageView.image = UIImage(named: "taylor_swift_bad_blood")
                }
                        
                let title = article!["title"] as? [String: Any]
                let titleRendered = title?["rendered"] as? String
                let cleanTitle = cleanTheTitle(title: titleRendered!)
                titleLabel.text = cleanTitle
                        
                let artContent = article!["content"] as? [String: Any]
                let content = artContent?["rendered"] as? String
                let authorName = author![0]["name"] as? String
                
                let string = article?["date"] as? String
                let dateFormatter = DateFormatter()
                let tempLocale = dateFormatter.locale // save locale temporarily
                dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                let date = dateFormatter.date(from: string!)!
                dateFormatter.dateFormat = "MMMM d, yyyy"
                dateFormatter.locale = tempLocale // reset the locale
                let dateString = dateFormatter.string(from: date)
                
                articleContent.attributedText = stringFromHtml(string: content!)
                subtitleLabel.text = authorName! + " - " + dateString
                
                let authorImages = author![0]["avatar_urls"] as? [String: Any]
                if let authorImg = authorImages!["96"] as? String {
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
                    userProfileImageView.image = UIImage(named: "taylor_swift_profile")
                }
                
            }
        }
    }
    
    func cleanTheTitle(title: String) -> String {
        return title.replacingOccurrences(of: "&#8211;", with: "-", options: .literal, range: nil).replacingOccurrences(of: "&#038;", with: "&", options: .literal, range: nil).replacingOccurrences(of: "&#8217;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&#8216;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&#233;", with: "é", options: .literal, range: nil).replacingOccurrences(of: "&#8230;", with: "...", options: .literal, range: nil).replacingOccurrences(of: "&#8212;", with: "--", options: .literal, range: nil)
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        // imageView.image = UIImage(named: "taylor_swift_bad_blood")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        // label.text = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
        return label
    }()
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        // imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 0
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.forestGreen.cgColor
        return imageView
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.forestGreen.cgColor
        button.setTitle("Share Article", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        button.setTitleColor(UIColor.forestGreen, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        var imageView = UIImage(named: "back_chevron")?.withRenderingMode(.alwaysTemplate)
        button.setImage(imageView, for: .normal)
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        button.tintColor = UIColor.white
        return button
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        //label.text = "Taylor Swift - March 13th 2018"
        return label
    }()
    let articleContent: UITextView = {
        let label = UITextView()
        label.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        label.backgroundColor = UIColor.clear
        label.isEditable = false
        return label
    }()
    
    @objc func buttonAction() {
        let eventURL = article?["link"] as? String
        print(eventURL!)
        let activityVC = UIActivityViewController(activityItems: [eventURL!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @objc func closeAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        self.view.addSubview(imageView)
        self.view.addSubview(userProfileImageView)
        self.view.addSubview(shareButton)
        self.view.addSubview(backButton)
        self.view.addSubview(titleLabel)
        self.view.addSubview(subtitleLabel)
        self.view.addSubview(articleContent)
        
        let imageHeight = Int(self.view.frame.height * 0.30)
        let labelHeight = 22
        
        // Horizontal Constraints
        self.view.addConstraintsWithFormat("H:|-0-[v0]-0-|", views: imageView)
        self.view.addConstraintsWithFormat("H:|-8-[v0(88)]|", views: userProfileImageView)
        self.view.addConstraintsWithFormat("H:|-104-[v0]-8-|", views: shareButton)
        self.view.addConstraintsWithFormat("H:|-0-[v0(44)]|", views: backButton)
        self.view.addConstraintsWithFormat("H:|-8-[v0]-8-|", views: titleLabel)
        self.view.addConstraintsWithFormat("H:|-8-[v0]-8-|", views: subtitleLabel)
        self.view.addConstraintsWithFormat("H:|-8-[v0]-8-|", views: articleContent)
        
        // Vertical Constraints
        self.view.addConstraintsWithFormat("V:|-0-[v0(\(imageHeight))]-8-|", views: imageView)
        self.view.addConstraintsWithFormat("V:|-16-[v0(44)]|", views: backButton)
        self.view.addConstraintsWithFormat("V:|-\(imageHeight - 44)-[v0(88)]|", views: userProfileImageView)
        self.view.addConstraintsWithFormat("V:|-\(imageHeight + 8)-[v0(36)]|", views: shareButton)
        self.view.addConstraintsWithFormat("V:|-\(imageHeight + 8 + 36 + 8)-[v0(\(labelHeight))]|", views: titleLabel)
        
        let variable = imageHeight + 8 + 36 + 8 + labelHeight + 8
        self.view.addConstraintsWithFormat("V:|-\(variable)-[v0(18)]|", views: subtitleLabel)
        
        let contentHeight = Int(self.view.frame.height) - variable - 18 - 16 - 8
        self.view.addConstraintsWithFormat("V:|-\(variable + 18 + 16)-[v0(\(contentHeight))]-8-|", views: articleContent)
        
    }
    
    // OnLoad ------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            if let d = data {
                let str = try NSAttributedString(data: d, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                return str
            }
        } catch {
        }
        return nil
    }
}
