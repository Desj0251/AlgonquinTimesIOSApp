//
//  ReporterViewController.swift
//  ATApp
//
//  Created by Janki on 2018-03-17.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit
import Photos

class ReporterViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var lblHelloName: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var imgViewPhoto: UIImageView!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var txtFieldTitle: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var name: String?
    var email: String?
    
    @IBOutlet weak var scrollViewBottomConstraints: NSLayoutConstraint!
    var picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.picker.delegate = self;
        // Do any additional setup after loading the view.
        
        txtFieldTitle.layer.cornerRadius = 5
        txtFieldTitle.layer.borderWidth = 1
        txtFieldTitle.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewDescription.layer.cornerRadius = 5
        txtViewDescription.layer.borderWidth = 1
        txtViewDescription.layer.borderColor = UIColor.lightGray.cgColor
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        
        lblHelloName.text = "Hello " + name!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action Method
    
    @IBAction func viewTapped(_ sender: Any) {
        view.endEditing(true);
    }
    
    @IBAction func closecClicked(_ sender: Any) {
        
        if txtFieldTitle.text != "" || txtViewDescription.text != "" || imgViewPhoto.image != UIImage (named: "") {
        
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
    @IBAction func viewPhotoClicked(_ sender: Any) {
        
        let alertVC = UIAlertController( title: "Upload Photo", message: "", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style:.default){ (action) in
            
            self.camera()
        }
        let photoAction = UIAlertAction(title: "Photo Library", style:.default){ (action) in
            self.photoFromLibrary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style:.cancel){ (action) in
        }
        
        alertVC.addAction(cameraAction)
        alertVC.addAction(photoAction)
        alertVC.addAction(cancelAction)
        
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        
        let alertVC = UIAlertController( title: "Success!", message: "Thank you for submission.", preferredStyle: .alert)
        let okAction = UIAlertAction( title: "OK", style:.default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
        alertVC.addAction(okAction)
        present( alertVC, animated: true,completion: nil)
    }
    
    @IBAction func photoFromLibrary() {

        let status = PHPhotoLibrary.authorizationStatus()
        if status == .authorized {
            
            self.picker.allowsEditing = true
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.picker, animated: true, completion: nil)
            
        }else{
            
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    
                    self.picker.allowsEditing = true
                    self.picker.sourceType = .photoLibrary
                    self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                    self.present(self.picker, animated: true, completion: nil)
                    
                }
            })
        }
    }
    
    @IBAction func camera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                if response {
                    //access granted
                    self.picker.allowsEditing = true
                    self.picker.sourceType = UIImagePickerControllerSourceType.camera
                    self.picker.cameraCaptureMode = .photo
                    self.present(self.picker,animated: true,completion: nil)
                    
                } else {
                }
            }
        }else{
            self.noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController( title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction( title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present( alertVC, animated: true,completion: nil)
    }

    // MARK: - Picker
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        let  chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        imgViewPhoto.image = chosenImage
        self.picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
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
