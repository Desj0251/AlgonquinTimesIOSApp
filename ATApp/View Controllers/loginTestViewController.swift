//
//  loginTestViewController.swift
//  ATApp
//
//  Created by John Desjardins on 2018-04-08.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class loginTestViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var chosenButton = 0
    var name: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    let blackView = UIView()
    let settingView: UIView = {
        let cv = UIView()
        cv.backgroundColor = UIColor.white
        return cv
    }()
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        return button
    }()
    let twitterButton: UIButton = {
        let button = UIButton()
//        button.setTitle("Continue with Twitter", for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
//        button.layer.cornerRadius = 3
//        button.backgroundColor = UIColor.rgb(42, 163, 239)
        
        func imageResize (image:UIImage, sizeChange:CGSize) -> UIImage{
            let hasAlpha = true
            let scale: CGFloat = 0.0 // Use scale factor of main screen
            UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
            image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            return scaledImage!
        }
        
        button.frame =  CGRect(x: 2, y: 74, width: 140, height: 40)
        button.tintColor = UIColor.white
        var shareImage = UIImage(named: "twitter")
        shareImage = imageResize(image: shareImage!, sizeChange: CGSize(width: 25, height: 25)).withRenderingMode(.alwaysTemplate)
        button.setImage(shareImage, for: .normal)
        button.tintColor = UIColor.white
        button.imageEdgeInsets = UIEdgeInsets(top: 6,left: 3,bottom: 6,right: 195)
        button.titleEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        button.setTitle("Continue with Twitter", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.layer.cornerRadius = 3
        button.backgroundColor = UIColor.rgb(42, 163, 239)
        
        return button
    }()
    let background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ACollege")!.alpha(0.1)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "atlogo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    let backButton: UIButton = {
        let button = UIButton()
        var imageView = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        button.setImage(imageView, for: .normal)
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        button.tintColor = UIColor.gray
        return button
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Black", size: 20.0)
        label.numberOfLines = 1
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.text = "Contribute to the Algonquin Times"
        return label
    }()
    let tipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send a Tip", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.addTarget(self, action: #selector(toAction2), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor.forestGreen
        return button
    }()
    @objc func toAction2(){
        chosenButton = 2
        actionButton()
    }
    let ideaButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit a Story Idea", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.addTarget(self, action: #selector(toAction1), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor.forestGreen
        return button
    }()
    @objc func toAction1(){
        chosenButton = 1
        actionButton()
    }
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    let terms: UIButton = {
        let button = UIButton()
        button.setTitle("Terms and Conditions", for: .normal)
        button.setTitleColor(UIColor.forestGreen, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        //button.addTarget(self, action: #selector(nil), for: .touchUpInside)
        return button
    }()
    func setupView(){
        self.view.addSubview(background)
        view.sendSubview(toBack: background)
        self.view.addSubview(backButton)
        self.view.addSubview(logo)
        self.view.addSubview(titleLabel)
        self.view.addSubview(tipButton)
        self.view.addSubview(seperatorView)
        self.view.addSubview(ideaButton)
        self.view.addSubview(terms)
        
        let height = self.view.frame.height
        let width = self.view.frame.width
        
        view.addConstraintsWithFormat("H:|-0-[v0(\(width))]-0-|", views: background)
        view.addConstraintsWithFormat("V:|-0-[v0(\(height))]-0-|", views: background)
        
        view.addConstraintsWithFormat("H:|-4-[v0(33)]|", views: backButton)
        view.addConstraintsWithFormat("V:|-24-[v0(33)]|", views: backButton)
        
        let logoSize = width * 0.33
        view.addConstraintsWithFormat("V:|-\(height * 0.1)-[v0(\(logoSize))]|", views: logo)
        view.addConstraintsWithFormat("H:|-\((width / 2) - (logoSize / 2))-[v0(\(logoSize))]|", views: logo)
        
        view.addConstraintsWithFormat("V:|-\(height * 0.1 + (logoSize) + 24)-[v0(30)]|", views: titleLabel)
        view.addConstraintsWithFormat("H:|-16-[v0]-16-|", views: titleLabel)
        
        view.addConstraintsWithFormat("H:|-16-[v0]-16-|", views: tipButton)
        view.addConstraintsWithFormat("V:|-\(height * 0.5)-[v0(50)]|", views: tipButton)
        
        view.addConstraintsWithFormat("V:|-\(height * 0.5 + 100)-[v0(1)]|", views: seperatorView)
        view.addConstraintsWithFormat("H:|-32-[v0]-32-|", views: seperatorView)
        
        view.addConstraintsWithFormat("V:|-\(height * 0.5 + 150)-[v0(50)]|", views: ideaButton)
        view.addConstraintsWithFormat("H:|-16-[v0]-16-|", views: ideaButton)
        
        view.addConstraintsWithFormat("V:|-\(height - 36)-[v0(20)]-16-|", views: terms)
        view.addConstraintsWithFormat("H:|-16-[v0]-16-|", views: terms)
    }
    
    @objc func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func actionButton() {
        if (FBSDKAccessToken.current()) != nil {
            fetchProfile()
        } else {
            if let window = UIApplication.shared.keyWindow {
                blackView.backgroundColor = UIColor(white: 0, alpha: 0.75)
                blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
                window.addSubview(blackView)
                blackView.frame = window.frame
                blackView.alpha = 0
                
                window.addSubview(settingView)
                
                let width = window.frame.width
                
                settingView.addSubview(loginButton)
                settingView.addConstraintsWithFormat("H:|-8-[v0(\(width - 16))]-8-|", views: loginButton)
                settingView.addConstraintsWithFormat("V:|-8-[v0(50)]|", views: loginButton)
                loginButton.delegate = self
                settingView.addSubview(twitterButton)
                settingView.addConstraintsWithFormat("H:|-8-[v0(\(width - 16))]-8-|", views: twitterButton)
                settingView.addConstraintsWithFormat("V:|-66-[v0(50)]|", views: twitterButton)
                
                // let cellHeight: CGFloat = window.frame.height * 0.25
                let cellHeight: CGFloat = 124.0
                let y = window.frame.height - cellHeight
                settingView.frame = CGRect(x: 0,y: window.frame.height, width: window.frame.width, height: cellHeight)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.blackView.alpha = 1
                    self.settingView.frame = CGRect(x: 0, y: y, width: self.settingView.frame.width, height: self.settingView.frame.height)
                }, completion: nil)
            }
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.settingView.frame = CGRect(x: 0, y: window.frame.height, width: self.settingView.frame.width, height: self.settingView.frame.height)
            }
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    }
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("completed login")
        fetchProfile()
    }
    
    func fetchProfile() {
        print("fetch profile")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) -> Void in
            
            if error != nil {
                print(error!)
                return
            }
            let data = result! as? [String: Any]
            print(data!["email"]!)
            
            self.handleDismiss()
            
            let first = data!["first_name"] as? String
            let last = data!["last_name"] as? String
            self.name = first! + " " + last!
            
            if self.chosenButton == 2 {
                self.performSegue(withIdentifier: "toReport", sender: self)
            } else if self.chosenButton == 1 {
                self.performSegue(withIdentifier: "toStory", sender: self)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStory" {
            if let destination = segue.destination as? StoryIdeaViewController {
                destination.name = name
                destination.prevVC = self
            }
        } else if segue.identifier == "toReport" {
            if let destination = segue.destination as? ReporterViewController {
                destination.name = name
                destination.prevVC = self
            }
        }
    }
}
