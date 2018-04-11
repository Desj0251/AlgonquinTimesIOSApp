//
//  SplashViewController.swift
//  ATApp
//
//  Created by John Desjardins on 2018-04-11.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.forestGreen
        
        self.view.addSubview(background)
        view.sendSubview(toBack: background)
        
        let height = self.view.frame.height
        let width = self.view.frame.width
        
        view.addConstraintsWithFormat("H:|-0-[v0(\(width))]-0-|", views: background)
        view.addConstraintsWithFormat("V:|-0-[v0(\(height))]-0-|", views: background)
        
    }

    let background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ACollege")!.alpha(0.1)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()

}
