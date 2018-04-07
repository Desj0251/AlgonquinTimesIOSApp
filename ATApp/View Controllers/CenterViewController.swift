//
//  CenterViewController.swift
//  ATApp
//
//  Created by Janki on 2018-03-17.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CenterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
}
