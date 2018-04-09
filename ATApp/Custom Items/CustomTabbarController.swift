//
//  CustomTabbarController.swift
//  ATApp
//
//  Created by Janki on 2018-03-12.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class CustomTabbarController: UITabBarController {
    
    let centerButton = UIButton.init(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set tabbar controller delegate
        self.delegate = self;
        
        centerButton.setImage(UIImage (named: "action")!, for: .normal)
        centerButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside);
        self.view.insertSubview(centerButton, aboveSubview: self.tabBar)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // safe place to set the frame of button manually
        centerButton.frame = CGRect.init(x: self.tabBar.center.x - 30, y: self.view.bounds.height - 55, width: 60, height: 60)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print(buttonAction)
        let destinationViewController = storyboard?.instantiateViewController(withIdentifier: "loginTestViewController") as! loginTestViewController
        present(destinationViewController, animated: true, completion: { })
    }

}

extension CustomTabbarController: UITabBarControllerDelegate{
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        
        if tabBarController.selectedIndex != 2{
            centerButton.isSelected = false;
//            centerButton.isEnabled = true;
        }
    }
}
