//
//  UIAlertControllerExtensions.swift
//  GameGo
//
//  Created by Amjad Tubasi on 12/17/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import Foundation
import UIKit

public extension UIAlertController {
    
    public class func showAlert(title:String = "GameGo".localized,
                         message:String? = nil,
                         doneButton:String = "OK".localized,
                         cancelButton:String? = nil,
                         doneCompletion:(()->())? = nil,
                         cancelCompletion:(()->())? = nil){
        
        guard !title.isBlank || !(message?.isBlank ?? false) else {
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: doneButton, style: UIAlertActionStyle.default, handler: {_ in
            doneCompletion?()
        }))
        
        if let cancel = cancelButton {
            alert.addAction(UIAlertAction(title: cancel, style: UIAlertActionStyle.cancel, handler: {_ in
                cancelCompletion?()
            }))
        }
        
        UIApplication.topViewController()?.presentVC(alert)

    }
    
    public class func showDefaultAlert(message:String){
        showAlert(message: message)
    }
    
    public class func showSuccessAlert(message:String){
        showAlert(message: message)
    }
    
    public class func showErrorAlert(message:String){
        showAlert(message: message)
    }
}
