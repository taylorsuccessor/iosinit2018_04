//
//  BaseTextField.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/5/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

typealias OnChangeTextCompletion = ((String)->())
typealias OnStartTyping = (()->(Bool))
typealias OnReturnButtonTap = (()->())
typealias OnEndTyping = ((String)->())

class BaseTextField: UITextField , UITextFieldDelegate {
    
    var onChangeText:OnChangeTextCompletion? = nil {
        didSet{
            self.delegate = self
        }
    }
    
    var onStartTyping : OnStartTyping? = nil {
        didSet{
            self.delegate = self
        }
    }
    
    var onReturnButtonTap : OnReturnButtonTap? = nil {
        didSet{
            self.delegate = self
        }
    }
    
    var onEndTyping : OnEndTyping? = nil {
        didSet{
            self.delegate = self
        }
    }
    
    @IBInspectable var hideKeyboardOnReturn: Bool = false
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        onChangeText?((text as NSString).replacingCharacters(in: range, with: string))
        return true
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        onChangeText?(textField.text ?? "")
        if let onStart = onStartTyping {
            return onStart()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        onEndTyping?(textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if hideKeyboardOnReturn {
            textField.resignFirstResponder()
        }
        onReturnButtonTap?()
        return true
    }
    
    
    
    func addRightLabel(text:String? = nil){
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.h))
        label.text = text
        label.textColor = self.textColor
        label.textAlignment = .center
        
        self.rightView = label
        self.rightViewMode = .always
    }
    
    var rightLabel : UILabel? {
        return self.rightView as? UILabel
    }
    
}
