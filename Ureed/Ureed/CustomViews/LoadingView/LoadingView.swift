//
//  LoadingView.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/19/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

import MBProgressHUD

class LoadingView: NSObject {
    
    class func showIn(view:UIView? = nil){
        guard let view = view ?? UIApplication.topViewController()?.view ?? AppDelegate.shared.window?.rootViewController?.view else {
            return
        }

        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = .indeterminate
        loadingNotification.show(animated: true)
    }
    
    class func hideIn(view:UIView? = nil){
        guard let view = view ?? UIApplication.topViewController()?.view ?? AppDelegate.shared.window?.rootViewController?.view else {
            return
        }
        MBProgressHUD.hide(for: view, animated: false)
    }
    
    class func hide(source vc:UIViewController? = nil){
        hideIn(view: vc?.view)
    }
    
    
}
