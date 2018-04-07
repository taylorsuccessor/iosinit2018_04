//
//  KeyboardLayoutConstraint.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/24/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

open class KeyboardLayoutConstraint: NSLayoutConstraint {
    
    fileprivate var offset : CGFloat = 0
    fileprivate var keyboardVisibleHeight : CGFloat = 0
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        offset = constant
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Notification
    
    @objc func keyboardWillShowNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        if let frameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let frame = frameValue.cgRectValue
            keyboardVisibleHeight = frame.size.height
        }
        
        self.updateConstant()
        switch (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber) {
        case let (.some(duration), .some(curve)):
            
            let options = UIViewAnimationOptions(rawValue: curve.uintValue)
            
            UIView.animate(
                withDuration: TimeInterval(duration.doubleValue),
                delay: 0,
                options: options,
                animations: {
                    UIApplication.shared.keyWindow?.layoutIfNeeded()
                    return
            }, completion: { finished in
            })
        default:
            
            break
        }
        
    }
    
    @objc func keyboardWillHideNotification(notification: NSNotification) {
        keyboardVisibleHeight = 0
        self.updateConstant()
        
        guard let userInfo = notification.userInfo else {return}
            
            switch (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber) {
            case let (.some(duration), .some(curve)):
                
                let options = UIViewAnimationOptions(rawValue: curve.uintValue)
                
                UIView.animate(
                    withDuration: TimeInterval(duration.doubleValue),
                    delay: 0,
                    options: options,
                    animations: {
                        UIApplication.shared.keyWindow?.layoutIfNeeded()
                        return
                }, completion: { finished in
                })
            default:
                break
            }
        
    }
    
    func updateConstant() {
        self.constant = offset + keyboardVisibleHeight
    }
    
}
