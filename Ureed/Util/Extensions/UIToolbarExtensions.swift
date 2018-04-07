//
//  UIToolbarExtensions.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/8/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import Foundation
import UIKit

public extension UIToolbar {

    public var isEnabled : Bool  {
        set{
            self.items?.forEach({$0.isEnabled = newValue})
        }get{
            return true
        }
    }
}
