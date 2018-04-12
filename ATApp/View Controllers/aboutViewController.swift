//
//  aboutViewController.swift
//  ATApp
//
//  Created by John Desjardins on 2018-04-12.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class aboutViewController: UIViewController {

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
        
        view.addSubview(backButton)
        view.addConstraintsWithFormat("H:|-4-[v0(33)]|", views: backButton)
        view.addConstraintsWithFormat("V:|-24-[v0(33)]|", views: backButton)
    }

}
