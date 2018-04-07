//
//  UISearchBarExtensions.swift
//  GameGo
//
//  Created by Amjad Tubasi on 1/2/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    /// Return text field inside a search bar
    public var textField: UITextField? {
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else { return nil
        }
        return textField
    }
}
