//
//  FormTextFieldCell.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/19/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

let FormTextFieldCellId = "FormTextFieldCell"
let FormTextFieldCellNibName = "FormTextFieldCell"
let FormTextFieldCellHeight : CGFloat = 56

protocol  FormTextFieldCellOutputDelegate {
    func didChangeTextFieldText(text:String?)
    func didEndEditing(text:String?)
    func didTapReturn(textfield:UITextField)
}

class FormTextFieldCell: BaseTableViewCell {

    @IBOutlet weak var textfield: BaseTextField!
    
    var delegate:FormTextFieldCellOutputDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textfield.autocorrectionType = .no
        textfield.delegate = self
    }
    
    var title:String? = nil {
        didSet{
           textfield.accessibilityLabel = title
           textfield.accessibilityIdentifier = title
          // textfield.title  = title
           textfield.placeholder = title
        }
    }
    
    var textValue:String? = nil {
        didSet{
            textfield.text = textValue
        }
    }
    
    var validationMessage:String? = nil {
        didSet{
            //textfield.errorMessage = validationMessage
        }
    }
    
    var keyboardType : UIKeyboardType = .default {
        didSet{
           textfield.keyboardType = keyboardType
           textfield.inputAccessoryView = nil
           textfield.addDoneToolbar = keyboardType == .phonePad || keyboardType == .numberPad
        }
    }
    
    var becomeTextFieldFirstResponder : Bool = false {
        didSet{
            if becomeTextFieldFirstResponder {
                self.textfield.becomeFirstResponder()
            }
        }
    }
    
    var returnKey : UIReturnKeyType = .default {
        didSet{
            self.textfield.returnKeyType = returnKey
        }
    }
    
    var textFieldLenght : Int?
    
//    var additionalString : String? = nil {
//        didSet{
//            textfield.rightLabel?.text = additionalString
//        }
//    }
}

extension FormTextFieldCell : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.didEndEditing(text: textField.text ?? "")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let changedText = (text as NSString).replacingCharacters(in: range, with: string)
        if let textFieldLenght = textFieldLenght , changedText.count > textFieldLenght {
            return false
        }
        delegate?.didChangeTextFieldText(text: changedText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didTapReturn(textfield: textfield)
        return true
    }
}
