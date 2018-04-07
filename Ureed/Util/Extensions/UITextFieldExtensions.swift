//
//  UITextFieldExtensions.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/17/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import Foundation
import UIKit

public extension UITextField  {
    
    
     @IBInspectable public var placeholderColor: UIColor {
        get {
            return UIColor.lightGray
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                            attributes: [NSAttributedStringKey.foregroundColor: newValue])
        }
    }
    
    public func addRightButton(_ image: UIImage, frame: CGRect,target:AnyObject?,selector:Selector) {
        let rightView = UIView()
        rightView.frame = frame
        let buttonFrame = CGRect(x: 0, y: 0, w: image.size.width, h: image.size.height)
        let button = UIButton(frame: buttonFrame)
        button.setImage(image, for: .normal)
        button.addTarget(target, action: selector, for: .touchUpInside)
        rightView.addSubview(button)
        button.centerInSuperView()
        self.rightView = rightView
        self.rightViewMode = UITextFieldViewMode.always
    }
    
    public var addDoneToolbar: Bool  {
        
        set{
            guard newValue else {
                self.inputAccessoryView = nil
                return
            }
                //self.inputAccessoryView = DoneToolbar(target: self, action: #selector(self.endTyping))
        }get{
            return false
        }
     
    }
    
    @objc func endTyping(){
        self.resignFirstResponder()
    }
}
