//
//  ArticleViewController.swift
//  ATApp
//
//  Created by John Desjardins on 2018-03-26.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorView: UILabel!
    @IBOutlet weak var bodyView: UITextView!
    
    var article: [String: Any] = [:]
    
    // OnLoad ------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let embedded = article["_embedded"] as? [String: Any] {
            let author = embedded["author"] as? [[String: Any]]
            
            if let media = embedded["wp:featuredmedia"] as? [[String: Any]] {
                let mediaDetails = media[0]["media_details"] as? [String: Any]
                let sizes = mediaDetails!["sizes"] as? [String: Any]
                let large = sizes!["large"] as? [String: Any]
                let imageUrl = large!["source_url"] as? String

                let url = URL(string: imageUrl!)
                DispatchQueue.main.async {
                    let data = try? Data(contentsOf: url!)
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data!)
                    }
                }
            }
            
            let articleContent = article["content"] as? [String: Any]
            let content = articleContent?["rendered"] as? String
            
            bodyView.text = content!.htmlDecoded
            authorView.text = author![0]["name"] as? String
        }
    }
}
