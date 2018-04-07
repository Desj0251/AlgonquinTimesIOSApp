//
//  CalendarViewController.swift
//  ATApp
//
//  Created by Christian Jurt on 2018-04-03.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBAction func closeButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)    }
    
    @IBOutlet weak var CalendarImageView: UIImageView!
    @IBOutlet weak var CalendarDescriptionTextView: UITextView!
    @IBOutlet weak var CalendarTitle: UILabel!
    
    var events: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = events?["title"] as? String
        let description = events?["description"] as? String
        
        
        if let media = events?["image"] as? [String: Any] {
            print("hello")
            let imageUrl = media["url"] as? String
            
            let url = URL(string: imageUrl!)
            DispatchQueue.main.async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    self.CalendarImageView.image = UIImage(data: data!)
                }
            }
        }
        
        let cleanTitle = title?.replacingOccurrences(of: "&#8211;", with: "-", options: .literal, range: nil).replacingOccurrences(of: "&#038;", with: "&", options: .literal, range: nil).replacingOccurrences(of: "&#8217;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&#8216;", with: "'", options: .literal, range: nil)
        
        let cleanDescription = description?.replacingOccurrences(of: "&#8211;", with: "-", options: .literal, range: nil).replacingOccurrences(of: "&#038;", with: "&", options: .literal, range: nil).replacingOccurrences(of: "&#8217;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&#8216;", with: "'", options: .literal, range: nil)
        
        CalendarTitle.numberOfLines = 2
        CalendarTitle.text = cleanTitle
        CalendarDescriptionTextView.text = cleanDescription?.htmlDecoded
    
    }

}
