//
//  SettingsViewController.swift
//  ATApp
//
//  Created by John Desjardins on 2018-03-17.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import AccountKit

class SettingsViewController: UIViewController, FBSDKLoginButtonDelegate {
  
    var accountKit: AKFAccountKit!
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    }
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    @objc func logoutAK() {
        print("logout success")
        accountKit.logOut()
        let alertVC = UIAlertController( title: "Logout Success", message: "Successfully logged out of AccountKit!", preferredStyle: .alert)
        let okAction = UIAlertAction( title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present( alertVC, animated: true,completion: nil)
    }
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255,alpha: 1)
        return view
    }()
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        return button
    }()
    
    let twitterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout of Account Kit", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.backgroundColor = UIColor.forestGreen
        return button
    }()
    
    func setupUI() {
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.75
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        let navigationTitlelabel = UILabel(frame: CGRect(x: 0,y: 0, width: 200, height: 21))
        navigationTitlelabel.center = CGPoint(x: 160, y: 284)
        navigationTitlelabel.textAlignment = NSTextAlignment.center
        navigationTitlelabel.textColor  = UIColor.white
        navigationTitlelabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        navigationTitlelabel.text = "Settings"
        
        self.navigationController!.navigationBar.topItem!.titleView = navigationTitlelabel
    
        let width = view.frame.width
        
        // Facebook logout cell ------------
        let cellView: UIView = {
            let view = UIView()
            return view
        }()
        view.addSubview(cellView)
        cellView.addSubview(loginButton)
        view.addConstraintsWithFormat("H:|-0-[v0(\(width))]-0-|", views: cellView)
        view.addConstraintsWithFormat("V:|-0-[v0(50)]|", views: cellView)
        cellView.addConstraintsWithFormat("H:|-8-[v0(\(width - 16))]-8-|", views: loginButton)
        cellView.addConstraintsWithFormat("V:|-8-[v0(34)]-8-|", views: loginButton)
        
        // Twitter logout cell ------------
        let cellView2: UIView = {
            let view = UIView()
            return view
        }()
        view.addSubview(cellView2)
        cellView2.addSubview(twitterButton)
        twitterButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logoutAK)))
        view.addConstraintsWithFormat("H:|-0-[v0(\(width))]-0-|", views: cellView2)
        view.addConstraintsWithFormat("V:|-50-[v0(50)]|", views: cellView2)
        cellView2.addConstraintsWithFormat("H:|-8-[v0(\(width - 16))]-8-|", views: twitterButton)
        cellView2.addConstraintsWithFormat("V:|-8-[v0(34)]-8-|", views: twitterButton)
        
        // Terms and Services cell ------------
        let cellView3: UIView = {
            let view = UIView()
            return view
        }()
        let goButton: UIButton = {
            let button = UIButton()
            let imageView = UIImage(named: "ic_chevron_right")?.withRenderingMode(.alwaysTemplate)
            button.setImage(imageView, for: .normal)
            button.addTarget(self, action: #selector(goToTerms), for: .touchUpInside)
            button.tintColor = UIColor.gray
            return button
        }()
        let terms: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.text = "Terms & Conditions"
            label.textColor = UIColor.darkGray
            return label
        }()
        view.addSubview(cellView3)
        cellView3.addSubview(terms)
        cellView3.addSubview(goButton)
        view.addConstraintsWithFormat("H:|-0-[v0(\(width))]-0-|", views: cellView3)
        view.addConstraintsWithFormat("V:|-100-[v0(50)]|", views: cellView3)
        cellView3.addConstraintsWithFormat("H:|-\(width - 46)-[v0(30)]-16-|", views: goButton)
        cellView3.addConstraintsWithFormat("V:|-8-[v0(30)]-8-|", views: goButton)
        cellView3.addConstraintsWithFormat("H:|-16-[v0]|", views: terms)
        cellView3.addConstraintsWithFormat("V:|-8-[v0(34)]-8-|", views: terms)
        
        // Terms and Services cell ------------
        let cellView4: UIView = {
            let view = UIView()
            return view
        }()
        let goButton2: UIButton = {
            let button = UIButton()
            let imageView = UIImage(named: "ic_chevron_right")?.withRenderingMode(.alwaysTemplate)
            button.setImage(imageView, for: .normal)
            button.addTarget(self, action: #selector(goToAbout), for: .touchUpInside)
            button.tintColor = UIColor.gray
            return button
        }()
        let about: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.text = "About Us & Contact Info"
            label.textColor = UIColor.darkGray
            return label
        }()
        view.addSubview(cellView4)
        cellView4.addSubview(about)
        cellView4.addSubview(goButton2)
        view.addConstraintsWithFormat("H:|-0-[v0(\(width))]-0-|", views: cellView4)
        view.addConstraintsWithFormat("V:|-150-[v0(50)]|", views: cellView4)
        cellView4.addConstraintsWithFormat("H:|-16-[v0]|", views: about)
        cellView4.addConstraintsWithFormat("V:|-8-[v0(34)]-8-|", views: about)
        cellView4.addConstraintsWithFormat("H:|-\(width - 46)-[v0(30)]-16-|", views: goButton2)
        cellView4.addConstraintsWithFormat("V:|-8-[v0(30)]-8-|", views: goButton2)
        
    }
    @objc func goToTerms() {
        let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "termsViewController") as! termsViewController
        present(destinationViewController, animated: true, completion: { })
    }
    @objc func goToAbout() {
        let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "aboutViewController") as! aboutViewController
        present(destinationViewController, animated: true, completion: { })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if accountKit == nil {
            self.accountKit = AKFAccountKit(responseType: AKFResponseType.accessToken)
            accountKit.requestAccount{
                (account, error) -> Void in
            }
        }
        setupUI()
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("completed login")
    }
    
}
