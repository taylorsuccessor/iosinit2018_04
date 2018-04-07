//
//  UIViewControllerExtensions.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/11/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    
    public var isModal: Bool {
        if let index = navigationController?.viewControllers.index(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController  {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
    
//    public func setAsRootController(withGesture:Bool = true){
//        if self.revealViewController() != nil {
//            let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "side_menu"), style: .plain, target: nil, action: nil)
//            self.navigationItem.leftBarButtonItem = menuButton
//            menuButton.target = self.revealViewController()
//            if Util.isRTL() {
//                menuButton.action = #selector(MenuNavigatorVC.rightRevealToggle(_:))
//            }else{
//                menuButton.action = #selector(MenuNavigatorVC.revealToggle(_:))
//            }
//            if withGesture {
//                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//            }
//
//        }
//    }
    
    public var isToolbarEnabled : Bool {
        set{
            self.navigationController?.toolbar.isEnabled = newValue
        }get {
            return true
        }
    }
    
    public func addTitleLabel(text:String? = nil,attributedString:NSAttributedString? = nil){
        
        
        guard let navigationBar = self.navBar else {
            return
        }
        let labelWidth = navigationBar.bounds.width - 110
        
        let label = UILabel(frame: CGRect(x:(navigationBar.bounds.width / 2) - (labelWidth/2), y:0, width:labelWidth, height:navigationBar.bounds.height))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.attributedText = attributedString
        label.text = text
        label.minimumScaleFactor = 0.5
        self.navigationItem.titleView = label
    }
    
}
