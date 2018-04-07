//
//  Colors.swift
//  Ureed
//
//  Created by Amjad Private on 2/19/18.
//  Copyright © 2018 Ureed. All rights reserved.
//

import Foundation
import UIKit
import Util

extension UIColor {

    class var gold: UIColor {
        return UIColor(hexString: "D5C507") ?? UIColor.lightGray
    }
    
    class var greyBackground : UIColor {
        return UIColor(hexString: "F8F8F8") ?? UIColor.lightGray
    }
    
    class var navigationBarTintColor : UIColor {
        return UIColor(hexString:"F7F7F7") ?? UIColor.white
    }
    
    class var navigationTintColor : UIColor {
        return UIColor(hexString:"7B7D8B") ?? UIColor.white
    }
    
    class var navigationShadowColor : UIColor {
        return UIColor(hexString:"E8E8E8") ?? UIColor.white
    }
    
    class var navigationTitleTextColor : UIColor {
        return UIColor.navigationTintColor
    }
    
    class var loginBackgroundColor : UIColor {
        return UIColor(hexString:"E5E5E5") ?? UIColor.white
    }
}
