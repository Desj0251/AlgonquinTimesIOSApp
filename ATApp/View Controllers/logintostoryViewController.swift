//
//  TestViewController.swift
//  ATApp
//
//  Created by John Desjardins on 2018-04-02.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class logintostoryViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var name: String?
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
        
        if (FBSDKAccessToken.current()) != nil {
            fetchProfile()
        }
        // Do any additional setup after loading the view.
    }
    
    func fetchProfile() {
        print("fetch profile")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            let data = result! as? [String: Any]
            print(data!["email"])
            
            let first = data!["first_name"] as? String
            let last = data!["last_name"] as? String
            self.name = first! + " " + last!
            
            self.performSegue(withIdentifier: "toStory", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStory" {
            if let destination = segue.destination as? StoryIdeaViewController {
                destination.name = name
                destination.prevVC = self
            }
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("completed login")
        fetchProfile()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }

    
}
