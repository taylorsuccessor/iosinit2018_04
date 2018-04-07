//
//  BaseTextView.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/23/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

let BaseTextViewPlacholderTag = 67

class BaseTextView: UITextView {
    
    override var text: String! {
        get{
          return super.text
        }
        set{
            super.text = newValue
            guard let placeholderLabel = self.viewWithTag(BaseTextViewPlacholderTag) else {return}
            placeholderLabel.isHidden = !newValue.isEmpty
        }
    }
    
    var placeholder : String  = "" {
        didSet{
            self.delegate = self
            let placeholderLabel = UILabel()
            placeholderLabel.text = placeholder
            placeholderLabel.font = UIFont.italicSystemFont(ofSize: (self.font?.pointSize)!)
            placeholderLabel.sizeToFit()
            placeholderLabel.tag = BaseTextViewPlacholderTag
            self.addSubview(placeholderLabel)
            placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize)! / 2)
            placeholderLabel.textColor = UIColor.lightGray
            placeholderLabel.isHidden = !self.text.isEmpty
        }
    }
    
    @IBInspectable var addDoneToolbar: Bool = false {
        didSet{
            guard addDoneToolbar else {
                self.inputAccessoryView = nil
                return
            }
            self.inputAccessoryView = DoneToolbar(target: self, action: #selector(self.endTyping))
        }
    }
    
    @objc func endTyping(){
        self.resignFirstResponder()
    }

}

extension BaseTextView : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let placeholderLabel = textView.viewWithTag(BaseTextViewPlacholderTag) else {return}
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
