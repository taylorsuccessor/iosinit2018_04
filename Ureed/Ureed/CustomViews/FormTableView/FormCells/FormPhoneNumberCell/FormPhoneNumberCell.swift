//
//  FormPhoneNumberCell.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/24/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

let FormPhoneNumberCellId = "FormPhoneNumberCell"
let FormPhoneNumberCellNibName = "FormPhoneNumberCell"
let FormPhoneNumberCellHeight : CGFloat = 50
let FormPhoneNumberCellHeightWithError : CGFloat = 77

class FormPhoneNumberCell: BaseTableViewCell {
    
    @IBOutlet weak var phoneNumberTextField: BaseTextField!
    @IBOutlet weak var dialCodeLabel: BaseLabel!
    @IBOutlet weak var validationLabel: BaseLabel!
    
    var delegate:FormTextFieldCellOutputDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        phoneNumberTextField.onChangeText = {text in
            self.delegate?.didChangeTextFieldText(text: text)
        }
        
        phoneNumberTextField.onEndTyping = {text in
            self.delegate?.didEndEditing(text: text)
        }
        
        phoneNumberTextField.onReturnButtonTap = {
            self.delegate?.didTapReturn(textfield: self.phoneNumberTextField)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var dialCode : String? = nil {
        didSet{
            dialCodeLabel.text = dialCode
        }
    }
    
    var phoneNumber : String? = nil {
        didSet{
            phoneNumberTextField.text = phoneNumber
        }
    }
    
    var becomeTextFieldFirstResponder : Bool = false {
        didSet{
            if becomeTextFieldFirstResponder {
                self.phoneNumberTextField.becomeFirstResponder()
            }
        }
    }
    
    var validationMessage:String? = nil {
        didSet{
            validationLabel.text = validationMessage
        }
    }
    
    var returnKey : UIReturnKeyType = .default {
        didSet{
            self.phoneNumberTextField.returnKeyType = returnKey
        }
    }
}
