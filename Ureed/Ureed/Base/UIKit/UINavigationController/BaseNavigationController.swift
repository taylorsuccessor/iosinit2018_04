//
//  BaseNavigationController.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/11/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    
    convenience init(_ rootViewController:UIViewController) {
        self.init(rootViewController: rootViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
