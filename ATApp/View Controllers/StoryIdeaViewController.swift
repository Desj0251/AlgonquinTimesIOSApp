//
//  StoryIdeaViewController.swift
//  ATApp
//
//  Created by Janki on 2018-03-17.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class StoryIdeaViewController: UIViewController {
    
    @IBOutlet weak internal var lblHelloName: UILabel!
    @IBOutlet weak var bottomConstraints: NSLayoutConstraint!
    
    @IBOutlet weak internal var btnSubmit: UIButton!
    @IBOutlet weak internal var txtViewDescription: UITextView!
    @IBOutlet weak internal var txtViewAdditionalInfo: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak internal var txtFieldTitle: UITextField!

    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
