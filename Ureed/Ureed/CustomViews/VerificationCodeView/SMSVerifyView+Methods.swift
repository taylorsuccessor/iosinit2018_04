//
//  SMSVerifyView+Methods.swift
//  SMSVerifyView
//
//  Created by Amjad Tubasi on 8/31/16.
//  Copyright © 2016 Amjad Tubasi. All rights reserved.
//

import Foundation
import UIKit

protocol VerifySMSCodeDelegate {
	func didFinishVerifyingCode(code:String)
	func didTapResendCode()
}

extension SMSVerifyView : UITextFieldDelegate {
	
	
	func clearFields (){
		
        self.fields.forEach({textField in
            textField.text = ""
            textField.isEnabled = textField == self.fields.first
        })
        becomeFieldsFirstResponder()
	}
	
	func clearError(){
        guard errorLabelHeightConstraint.constant == 20 else {
            return
        }
		errorMessageLabel.text = ""
		errorLabelHeightConstraint.constant = 0
		errorMessageLabel.layoutIfNeeded()
        self.fields.forEach({textField in
            textField.layer.masksToBounds = true
            textField.layer.borderColor = self.fieldsBorderColor.cgColor
        })
	}
	
	func showError(errorText:String ){
		errorLabelHeightConstraint.constant = 20
		errorMessageLabel.layoutIfNeeded()
		errorMessageLabel.text  = errorText
        self.fields.forEach({textField in
            textField.layer.masksToBounds = true
            textField.layer.borderColor = UIColor.red.cgColor
        })
	}
    
    func disableResendButton(){
        resendCodeButton.isEnabled = false
        resendCodeButton.setTitle("SMS_SENT".localized, for: .normal)
        resendCodeButton.setTitleColor(sentColor, for: .normal)
    }
    
    func enableResendButton(){
        resendCodeButton.isEnabled = true
        resendCodeButton.setTitle("RSEND_CODE".localized, for: .normal)
        resendCodeButton.setTitleColor(UIColor.blue, for: .normal)
    }
    
    func becomeFieldsFirstResponder(){
        self.fields.first?.becomeFirstResponder()
    }
    
}
