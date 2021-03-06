//
//  CalendarViewController.swift
//  ATApp
//
//  Created by John Desjardins on 2018-04-03.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit
import WebKit
import EventKit
import EventKitUI

class CalendarViewController: UIViewController {
    
    var savedEventId : String = ""
    
    var events: [String: Any]? {
        didSet {
            if let media = events?["image"] as? [String: Any] {
                //            print("hello")
                let imageUrl = media["url"] as? String
                
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
                self.imageView.image = UIImage(named: "image-not-found")
            }
            
            let title = events?["title"] as? String
            let description = events?["description"] as? String
            
            titleLabel.text = cleanTheTitle(title: title!)
            //articleContent.attributedText = stringFromHtml(string: description!)
            articleContent.loadHTMLString("<html><body><p><font size=14>" + description!, baseURL: nil)
            
        }
    }
    
    func cleanTheTitle(title: String) -> String {
        return title.replacingOccurrences(of: "&#8211;", with: "-", options: .literal, range: nil).replacingOccurrences(of: "&#038;", with: "&", options: .literal, range: nil).replacingOccurrences(of: "&#8217;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&#8216;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&#233;", with: "é", options: .literal, range: nil).replacingOccurrences(of: "&#8230;", with: "...", options: .literal, range: nil).replacingOccurrences(of: "&#8212;", with: "--", options: .literal, range: nil)
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "taylor_swift_bad_blood")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        //label.text = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
        return label
    }()
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SA-Icon")
        imageView.layer.cornerRadius = 0
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.forestGreen.cgColor
        return imageView
    }()
    
    let shareButton: UIButton = {
        
        func imageResize (image:UIImage, sizeChange:CGSize) -> UIImage{
            let hasAlpha = true
            let scale: CGFloat = 0.0 // Use scale factor of main screen
            UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
            image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            return scaledImage!
        }
        
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.forestGreen.cgColor
        var shareImage = UIImage(named: "share")
        shareImage = imageResize(image: shareImage!, sizeChange: CGSize(width: 20, height: 20)).withRenderingMode(.alwaysTemplate)
        button.setImage(shareImage, for: .normal)
        button.tintColor = UIColor.forestGreen
//        button.setTitle("Share", for: .normal)
//        button.setTitleColor(UIColor.forestGreen, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    let calendarButton: UIButton = {
        
        func imageResize (image:UIImage, sizeChange:CGSize) -> UIImage{
            let hasAlpha = true
            let scale: CGFloat = 0.0 // Use scale factor of main screen
            UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
            image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            return scaledImage!
        }
        
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.forestGreen.cgColor
        var shareImage = UIImage(named: "calendar3x")
        shareImage = imageResize(image: shareImage!, sizeChange: CGSize(width: 20, height: 20)).withRenderingMode(.alwaysTemplate)
        button.setImage(shareImage, for: .normal)
        button.tintColor = UIColor.forestGreen
//        button.setTitle("Add to Calendar", for: .normal)
//        button.setTitleColor(UIColor.forestGreen, for: .normal)
        button.addTarget(self, action: #selector(saveEvent), for: .touchUpInside)
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

    let articleContent: WKWebView = {
        let label = WKWebView()
        return label
    }()
    
    @objc func buttonAction() {
        let eventURL = events?["url"] as? String
        let activityVC = UIActivityViewController(activityItems: [eventURL!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @objc func closeAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveEvent(){
        let eventStore = EKEventStore()
        let CalendarTitle = events?["title"] as? String
        
        let CleanCalendarTitle = cleanTheTitle(title: CalendarTitle!)
        
        let sDate = events?["start_date"] as? String
        let eDate = events?["end_date"] as? String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let startDate = dateFormatter.date(from: sDate!)
        let endDate = dateFormatter.date(from: eDate!)
        
        if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
            eventStore.requestAccess(to: .event, completion: {
                granted, error in
                self.createEvent(eventStore: eventStore, title: CleanCalendarTitle, startDate: startDate! as NSDate, endDate: endDate as! NSDate)
            })
        } else {
            createEvent(eventStore: eventStore, title: CleanCalendarTitle, startDate: startDate! as NSDate, endDate: endDate! as NSDate)
        }
    }
    
    func createEvent(eventStore: EKEventStore, title: String, startDate: NSDate, endDate: NSDate) {
        
        let event = EKEvent(eventStore: eventStore)
        let alarm2:EKAlarm = EKAlarm(relativeOffset: -3600)
        
        let EventURL = events?["url"] as? String
        
        if let EventLocation = events?["venue"] as? [String: Any]
        {
            let EventVenue = EventLocation["address"] as? String
            event.location = EventVenue!
        }
        
        event.url = URL(string: EventURL!)
        event.alarms = [alarm2]
        event.title = title
        event.startDate = startDate as Date!
        event.endDate = endDate as Date!
        
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            
            try eventStore.save(event, span: .thisEvent)
            savedEventId = event.eventIdentifier
        } catch {
            print("Error Saving")
        }
        
        let controller = EKEventEditViewController()
        controller.event = event
        controller.eventStore = eventStore
        controller.editViewDelegate = self
        present(controller, animated: true)
    }
    
    func setupUI() {
        self.view.addSubview(imageView)
        self.view.addSubview(userProfileImageView)
        self.view.addSubview(shareButton)
        self.view.addSubview(backButton)
        self.view.addSubview(titleLabel)
        self.view.addSubview(articleContent)
        self.view.addSubview(calendarButton)
        
        let imageHeight = Int(self.view.frame.height * 0.30)
        let labelHeight = 22

        let buttonWidth = (Int(self.view.frame.width) - 96 - 16 - 8) / 2
        
        // Horizontal Constraints
        self.view.addConstraintsWithFormat("H:|-0-[v0]-0-|", views: imageView)
        self.view.addConstraintsWithFormat("H:|-8-[v0(88)]|", views: userProfileImageView)
        self.view.addConstraintsWithFormat("H:|-104-[v0(\(buttonWidth))]-8-[v1(\(buttonWidth))]-8-|", views: shareButton, calendarButton)
        self.view.addConstraintsWithFormat("H:|-0-[v0(44)]|", views: backButton)
        self.view.addConstraintsWithFormat("H:|-8-[v0]-8-|", views: titleLabel)
        self.view.addConstraintsWithFormat("H:|-8-[v0]-8-|", views: articleContent)
        
        // Vertical Constraints
        self.view.addConstraintsWithFormat("V:|-0-[v0(\(imageHeight))]-8-|", views: imageView)
        self.view.addConstraintsWithFormat("V:|-16-[v0(44)]|", views: backButton)
        self.view.addConstraintsWithFormat("V:|-\(imageHeight - 44)-[v0(88)]|", views: userProfileImageView)
        self.view.addConstraintsWithFormat("V:|-\(imageHeight + 8)-[v0(36)]|", views: shareButton)
        self.view.addConstraintsWithFormat("V:|-\(imageHeight + 8)-[v0(36)]|", views: calendarButton)
        self.view.addConstraintsWithFormat("V:|-\(imageHeight + 8 + 36 + 8)-[v0(\(labelHeight))]|", views: titleLabel)
        
        let variable = imageHeight + 8 + 36 + 8 + labelHeight + 8
        let contentHeight = Int(self.view.frame.height) - variable - 8
        self.view.addConstraintsWithFormat("V:|-\(variable)-[v0(\(contentHeight))]-8-|", views: articleContent)
        
    }
    
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

extension UIViewController: EKEventEditViewDelegate {
    
    public func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true)
    }
    
}
