//
//  CustomTabbarController.swift
//  ATApp
//
//  Created by Janki on 2018-03-12.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class CustomTabbarController: UITabBarController {
    
    let cenerButton = UIButton.init(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set tabbar controller delegate
        self.delegate = self;

        //Add custom button on top of tabbar
        cenerButton.setTitleColor(.black, for: .normal)
        cenerButton.setTitleColor(.blue, for: .highlighted)
        
        cenerButton.setImage(UIImage (named: "bookmark")!, for: .normal)
        cenerButton.setImage(UIImage (named: "bookmark-selected")!, for: .selected)
        
        cenerButton.backgroundColor = UIColor.lightGray
        cenerButton.layer.cornerRadius = 30
        cenerButton.layer.borderWidth = 1
        cenerButton.layer.borderColor = UIColor.forestGreen.cgColor
        cenerButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside);
        self.view.insertSubview(cenerButton, aboveSubview: self.tabBar)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // safe place to set the frame of button manually
        cenerButton.frame = CGRect.init(x: self.tabBar.center.x - 30, y: self.view.bounds.height - 73, width: 60, height: 60)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        
        self.selectedIndex = 2;
        cenerButton.isSelected = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension CustomTabbarController: UITabBarControllerDelegate{
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        
        if tabBarController.selectedIndex != 2{
            cenerButton.isSelected = false;
//            cenerButton.isEnabled = true;
        }
    }
}
