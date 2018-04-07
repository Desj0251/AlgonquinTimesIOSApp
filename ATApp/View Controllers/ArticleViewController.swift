//
//  ArticleViewController.swift
//  ATApp
//
//  Created by John Desjardins on 2018-03-26.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    var article: [String: Any] = [:]
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor_swift_bad_blood")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        label.text = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
        return label
    }()
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor_swift_profile")
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
        //label.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        label.textColor = UIColor.gray
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.text = "Taylor Swift - March 13th 2018"
        return label
    }()
    let articleContent: UITextView = {
        let label = UITextView()
        label.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        label.backgroundColor = UIColor.clear
        label.text = "Taylor Alison Swift (born December 13, 1989) is an American singer-songwriter. One of the leading contemporary recording artists, she is known for narrative songs about her personal life, which have received widespread media coverage.\nBorn and raised in Pennsylvania, Swift moved to Nashville, Tennessee at the age of 14 to pursue a career in country music. She signed with the label Big Machine Records and became the youngest artist ever signed by the Sony/ATV Music publishing house. Her 2006 self-titled debut album peaked at number five on the Billboard 200 and spent the most weeks on the chart in the 2000s. The album's third single, \"Our Song\", made her the youngest person to single-handedly write and perform a number-one song on the Hot Country Songs chart. Swift's second album, Fearless, was released in 2008. Buoyed by the success of pop crossover singles \"Love Story\" and \"You Belong with Me\", Fearless became the best-selling album of 2009 in the United States. The album won four Grammy Awards, with Swift becoming the youngest Album of the Year winner./nTaylor Alison Swift (born December 13, 1989) is an American singer-songwriter. One of the leading contemporary recording artists, she is known for narrative songs about her personal life, which have received widespread media coverage.\nBorn and raised in Pennsylvania, Swift moved to Nashville, Tennessee at the age of 14 to pursue a career in country music. She signed with the label Big Machine Records and became the youngest artist ever signed by the Sony/ATV Music publishing house. Her 2006 self-titled debut album peaked at number five on the Billboard 200 and spent the most weeks on the chart in the 2000s. The album's third single, \"Our Song\", made her the youngest person to single-handedly write and perform a number-one song on the Hot Country Songs chart. Swift's second album, Fearless, was released in 2008. Buoyed by the success of pop crossover singles \"Love Story\" and \"You Belong with Me\", Fearless became the best-selling album of 2009 in the United States. The album won four Grammy Awards, with Swift becoming the youngest Album of the Year winner."
        return label
    }()
    
    @objc func buttonAction() {
        print("shit happens")
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
        self.view.addConstraintsWithFormat("H:|-16-[v0]-16-|", views: articleContent)
        
        // Vertical Constraints
        self.view.addConstraintsWithFormat("V:|-0-[v0(\(imageHeight))]-8-|", views: imageView)
        self.view.addConstraintsWithFormat("V:|-16-[v0(44)]|", views: backButton)
        self.view.addConstraintsWithFormat("V:|-\(imageHeight - 44)-[v0(88)]|", views: userProfileImageView)
        self.view.addConstraintsWithFormat("V:|-\(imageHeight + 8)-[v0(36)]|", views: shareButton)
        self.view.addConstraintsWithFormat("V:|-\(imageHeight + 8 + 36 + 8)-[v0(\(labelHeight))]|", views: titleLabel)
        
        let variable = imageHeight + 8 + 36 + 8 + labelHeight + 8
        self.view.addConstraintsWithFormat("V:|-\(variable)-[v0(18)]|", views: subtitleLabel)
        
        let contentHeight = Int(self.view.frame.height) - variable - 18 - 16 - 16
        self.view.addConstraintsWithFormat("V:|-\(variable + 18 + 16)-[v0(\(contentHeight))]-16-|", views: articleContent)
        
    }
    
    // OnLoad ------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
//        if let embedded = article["_embedded"] as? [String: Any] {
//            let author = embedded["author"] as? [[String: Any]]
//            
//            if let media = embedded["wp:featuredmedia"] as? [[String: Any]] {
//                let mediaDetails = media[0]["media_details"] as? [String: Any]
//                let sizes = mediaDetails!["sizes"] as? [String: Any]
//                let large = sizes!["large"] as? [String: Any]
//                let imageUrl = large!["source_url"] as? String
//
//                let url = URL(string: imageUrl!)
//                DispatchQueue.main.async {
//                    let data = try? Data(contentsOf: url!)
//                    DispatchQueue.main.async {
//                        self.imageView.image = UIImage(data: data!)
//                    }
//                }
//            }
//            
//            let articleContent = article["content"] as? [String: Any]
//            let content = articleContent?["rendered"] as? String
//            
//            bodyView.attributedText = stringFromHtml(string: content!)
//            authorView.text = author![0]["name"] as? String
//        }
    }
    
//    func imageResize (image:UIImage, sizeChange:CGSize) -> UIImage{
//
//        let hasAlpha = true
//        let scale: CGFloat = 0.0 // Use scale factor of main screen
//
//        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
//        image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
//
//        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
//        return scaledImage!
//    }
    
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
