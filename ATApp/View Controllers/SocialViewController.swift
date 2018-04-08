//
//  SocialViewController.swift
//  ATApp
//
//  Created by John Desjardins on 2018-03-17.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit
import WebKit

class SocialViewController: UIViewController {
    
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnTwitter: UIButton!
    @IBOutlet weak var btnInstagram: UIButton!
    @IBOutlet weak var webview: WKWebView!
    
    @IBOutlet weak var leadingConstraints: NSLayoutConstraint!
    var arrayTabledata:NSMutableArray = NSMutableArray()
    var selectedIndex : Int = 0;
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
        moreSetup()
        
        // Do any additional setup after loading the view.
        self.selectedIndex = 0
        
        webRequest(webUrl: "https://www.powr.io/plugins/social-feed/view?unique_label=c7e88f1e_1522791460&external_type=iframe")
    }
    
    func webRequest(webUrl: String){
        guard let url = URL(string: webUrl) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        self.webview.load(request)
    }
    
    func animateNav(){
        UIView.animate(withDuration: 0.2, animations: {
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func moreSetup(){
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.transform = transform
        activityIndicator.center = self.view.center
        
        self.view.addSubview(activityIndicator)
        self.webview.navigationDelegate = self
    }
    
    func setNav(){
        let navigationTitlelabel = UILabel(frame: CGRect(x: 0,y: 0, width: 200, height: 21))
        navigationTitlelabel.center = CGPoint(x: 160, y: 284)
        navigationTitlelabel.textAlignment = NSTextAlignment.center
        navigationTitlelabel.textColor  = UIColor.white
        navigationTitlelabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        navigationTitlelabel.text = "Social"
        
        self.navigationController!.navigationBar.topItem!.titleView = navigationTitlelabel
    }
    
    @IBAction func segmentClicked(_ sender: Any) {
        
        self.selectedIndex = (sender as AnyObject).tag
        
        switch self.selectedIndex {
        case 1:
            self.leadingConstraints.constant = 0;
            animateNav()
            
            webRequest(webUrl: "https://www.powr.io/plugins/social-feed/view?unique_label=c7e88f1e_1522791460&external_type=iframe")
            break
        case 2:
            self.leadingConstraints.constant = self.btnFacebook.frame.size.width;
            animateNav()
            
            webRequest(webUrl: "https://www.powr.io/plugins/facebook-feed/view?unique_label=b4bb604e_1522789433&external_type=iframe")
            break
        case 3:
            self.leadingConstraints.constant = 2 * self.btnFacebook.frame.size.width;
            animateNav()
            webRequest(webUrl: "https://www.powr.io/plugins/instagram-feed/view?unique_label=0f6fe7b9_1521304270&external_type=iframe")
            break
        default:
            break
        }
    }
}

extension SocialViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webview.alpha = 0
        activityIndicator.startAnimating()
        //print("Started navigating to url \(String(describing: webView.url))")
    }
    @objc func delayedAction() {
        webview.alpha = 1
        self.activityIndicator.stopAnimating()
    }
}
