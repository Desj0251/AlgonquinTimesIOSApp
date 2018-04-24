//
//  aboutViewController.swift
//  ATApp
//
//  Created by John Desjardins on 2018-04-12.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class aboutViewController: UIViewController {

    let backButton: UIButton = {
        let button = UIButton()
        var imageView = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        button.setImage(imageView, for: .normal)
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        button.tintColor = UIColor.gray
        return button
    }()
    @objc func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
    let terms: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "About Us & Contact Info"
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        return label
    }()
    let articleContent: UITextView = {
        
        func stringFromHtml(string: String) -> NSAttributedString? {
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
        
        let label = UITextView()
        label.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        label.backgroundColor = UIColor.clear
        label.attributedText = stringFromHtml(string: "This app was designed to give students a one stop place to find out about all the news and events happening around campus. The major aim of the app is to encourage all students to be \"Student Reporters\" by allowing them to submit either tips or story ideas. Algonquin Times journalists will use these submissions to write articles that will be published on their website, app and/or in print. Some submissions will also be used to create Facebook, Twitter or Instagram posts which can all be seen in the social media page of the app.The Algonquin Times App was designed and developed by Jasper Development, a group of students from Algonquin’s Mobile Application Design and Development program.<br><br> <strong>Jasper Development:</strong> <br><br>Christian Jurt - Project Lead<br>Janki Padaliya. - IOS Designer<br>Jonathan Dure - Design Lead<br>John Desjardins - IOS Developer<br>Marjan Tropper - Android Developer<br>Rajat Kumar - Interaction Designer<br>Ramon Tabilin - Android Designer")
        label.isEditable = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height = self.view.frame.height
        
        view.addSubview(backButton)
        view.addConstraintsWithFormat("H:|-4-[v0(33)]|", views: backButton)
        view.addConstraintsWithFormat("V:|-24-[v0(33)]|", views: backButton)
        view.addSubview(terms)
        view.addConstraintsWithFormat("H:|-73-[v0]-73-|", views: terms)
        view.addConstraintsWithFormat("V:|-24-[v0(33)]-\(height - 57)-|", views: terms)
        view.addSubview(articleContent)
        view.addConstraintsWithFormat("H:|-8-[v0]-8-|", views: articleContent)
        view.addConstraintsWithFormat("V:|-65-[v0(\(height - 65 - 8))]-8-|", views: articleContent)
    }

}
