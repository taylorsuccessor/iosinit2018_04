//
//  UIApplicationExtensions.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/11/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import Foundation
import UIKit
//import SWRevealViewController

public extension UIApplication {
    
//    class var menuNavigator : MenuNavigatorVC? {
//        return self.topViewController() as? MenuNavigatorVC
//    }
    
    public class var appVersion:String? {
    
        if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString"){
            return "\(appVersion)"
        }
        return nil
    }
    
    public class var buildNumber:String? {
    
        if let buildNum = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String){
            return "\(buildNum)"
        }
        return nil
    }
    
//    class func topNavigationController(for source:UIViewController? = nil)->UINavigationController?{
//        return source?.navigationController ?? UIApplication.topViewController()?.navigationController ?? (UIApplication.topViewController() as? MenuNavigatorVC)?.frontViewController as? UINavigationController
//    }
    
}
