//
//  NanigationBarStyle.swift
//  Ureed
//
//  Created by Amjad Private on 3/3/18.
//  Copyright © 2018 Ureed. All rights reserved.
//

import Foundation
import UIKit
import KMNavigationBarTransition

enum NavigationBarStyle {
    
    case translucent(tintColor:UIColor)
    case color(barColor:UIColor)
    case `default`
    
    func setTheme(for navigationController:UINavigationController?){
        
        switch self {
            
        case .color(let color):
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            //            navigationController?.navigationBar.shadowImage = nil
            navigationController?.navigationBar.barTintColor = color
            navigationController?.navigationBar.tintColor = UIColor.lightGray
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.blue]
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.barStyle = .blackTranslucent
            //navigationController?.navigationBar.shadowImage = UIImage()
            
            
        case .translucent(let tintColor):
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.backgroundColor = UIColor.clear
            navigationController?.navigationBar.tintColor = tintColor
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.barStyle = .blackOpaque

            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.blue]
            
        case .`default`:
            navigationController?.navigationBar.setBackgroundImage(UIImage(color: UIColor.navigationBarTintColor), for: .default)
            //            navigationController?.navigationBar.shadowImage = nil
            navigationController?.navigationBar.barTintColor = UIColor.navigationBarTintColor
            navigationController?.navigationBar.tintColor = UIColor.navigationTintColor
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.navigationTitleTextColor]
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.barStyle = .default
            navigationController?.navigationBar.shadowImage = UIImage(color: .navigationShadowColor)
            

        }
    }
}


