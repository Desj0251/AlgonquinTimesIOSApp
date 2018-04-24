//
//  StoryIdeaViewController.swift
//  ATApp
//
//  Created by Janki on 2018-03-17.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit
import MessageUI

class StoryIdeaViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak internal var lblHelloName: UILabel!
    @IBOutlet weak var bottomConstraints: NSLayoutConstraint!
    
    @IBOutlet weak internal var btnSubmit: UIButton!
    @IBOutlet weak internal var txtViewDescription: UITextView!
    @IBOutlet weak internal var txtViewAdditionalInfo: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak internal var txtFieldTitle: UITextField!

    var name: String? = ""
    var prevVC: UIViewController!
    
    func sendEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(["desjjoh@gmail.com"])
        composeVC.setSubject("Test Emails")
        composeVC.setMessageBody("Hello this is a test Email", isHTML: false)
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let prevVC: logintostoryViewController!
        // prevVC.dismiss(animated: false, completion: nil)
        
        self.view.addSubview(backButton)
        
        view.addConstraintsWithFormat("H:|-4-[v0(33)]|", views: backButton)
        view.addConstraintsWithFormat("V:|-24-[v0(33)]|", views: backButton)
        
        // Do any additional setup after loading the view.
        
        txtFieldTitle.layer.cornerRadius = 5
        txtFieldTitle.layer.borderWidth = 1
        txtFieldTitle.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewDescription.layer.cornerRadius = 5
        txtViewDescription.layer.borderWidth = 1
        txtViewDescription.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewAdditionalInfo.layer.cornerRadius = 5
        txtViewAdditionalInfo.layer.borderWidth = 1
        txtViewAdditionalInfo.layer.borderColor = UIColor.lightGray.cgColor
        
        lblHelloName.text = "Hello " + name!
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        
        self.registerNotificationObservers()
    }
    
    deinit {
        self.removeNotificationObservers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    // MARK: - Action Method
    
    @IBAction func viewTapped(_ sender: Any) {
        view.endEditing(true);
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        sendEmail()
        
        let alertVC = UIAlertController( title: "Success!", message: "Thank you for submission.", preferredStyle: .alert)
        let okAction = UIAlertAction( title: "OK", style:.default) { (action) in
            self.dismiss(animated: true, completion: nil);
        }
        alertVC.addAction(okAction)
        present( alertVC, animated: true,completion: nil)
    }
    
    @IBAction func closecClicked(_ sender: Any) {
        
        if txtFieldTitle.text != "" || txtViewDescription.text != "" || txtViewAdditionalInfo.text != "" {
            
            let alertVC = UIAlertController( title: "Are you sure?!", message: "All entries will be discarded.", preferredStyle: .alert)
            let cancelAction = UIAlertAction( title: "Cancel", style:.cancel) { (action) in
            }
            let confirm = UIAlertAction( title: "Confirm", style:.destructive) { (action) in
                self.dismiss(animated: true, completion: nil);
            }
            alertVC.addAction(cancelAction)
            alertVC.addAction(confirm)
            present( alertVC, animated: true,completion: nil)
        }else{
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Keyboard Methods
    
    func registerNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func removeNotificationObservers() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        {
            self.bottomConstraints.constant = keyboardSize.height;
        }
        print("keyboardWillShow")
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        self.bottomConstraints.constant = 0;        
    }

}
