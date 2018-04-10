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

class SettingsViewController: UIViewController, FBSDKLoginButtonDelegate {
  
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    }
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        view.addSubview(loginButton)
        
        let width = view.frame.width
        
        view.addConstraintsWithFormat("H:|-8-[v0(\(width - 16))]-8-|", views: loginButton)
        view.addConstraintsWithFormat("V:|-8-[v0(50)]|", views: loginButton)
        
        // Do any additional setup after loading the view.
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("completed login")
        //fetchProfile()
    }
    
}
