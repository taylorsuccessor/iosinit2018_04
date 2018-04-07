//
//  TextFieldFormRowItem.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/19/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

class TextFieldFormRowItem: FormRowItem {

    var title:String?
    var value:String?
    var keyboardType : UIKeyboardType = .default
    var additionalInfo:String?
    var isSecureTextField = false
    
    var textFieldLenght:Int?
    
    convenience init(title:String?,value:String?,keyboardType : UIKeyboardType = .default){
        self.init()
        self.title = title
        self.value = value
        self.keyboardType = keyboardType
        self.type = .textField
    }
    
    override func perpareItemRow(for formTableView: FormTableView) {
        formTableView.registeCell(nibName: FormTextFieldCellNibName, Id: FormTextFieldCellId)
    }
    
    override func cellForItemRow(for formTableView: FormTableView, at indexPath: IndexPath)->BaseTableViewCell {
        let cell = formTableView.dequeueReusableCell(withIdentifier: FormTextFieldCellId, for: indexPath) as! FormTextFieldCell
        cell.delegate = self
        cell.textValue = value
        cell.title = title
        cell.validationMessage = validationMessage
        cell.keyboardType = keyboardType
        cell.textFieldLenght = textFieldLenght
//        cell.additionalString = additionalInfo
        cell.textfield.isSecureTextEntry = isSecureTextField
        if shouldFoucsOnItem {
            shouldFoucsOnItem = false
            cell.becomeTextFieldFirstResponder = true
        }
        cell.returnKey = .done
        return cell
    }
    
    override func heightForItemRow(for formTableView: FormTableView, at indexPath: IndexPath)->CGFloat {
        return  FormTextFieldCellHeight
    }
    
    override func isFormItemRowValidToSubmit(for formTableView: FormTableView, at indexPath: IndexPath) -> Bool {
        let isValid = isValidTextField()
        formTableView.reloadData()
        return isValid
    }
    
    override var itemValue: Any? {
        get{return value}
    }
    
    func isValidTextField()->Bool {
        validationMessage = nil
        switch itemValidation {
        case .customValidations(let delegate):
            if let errorMessage = delegate.validationMessage(for: self){
                validationMessage = errorMessage
                return false
            }
        case .mandatory(let errorMessage):
            if  (itemValue as? String).isBlank {
                validationMessage = errorMessage
                return false
            }
        default:
            return true
        }
        return true
    }
}

extension TextFieldFormRowItem : FormTextFieldCellOutputDelegate {
    
    func didEndEditing(text: String?) {
        _ = isValidTextField()
        self.formRowItemActions?.shouldReload(item: self)
    }
    
    func didChangeTextFieldText(text: String?) {
        self.value = text
    }
    
    func didTapReturn(textfield:UITextField) {
        textfield.resignFirstResponder()
    }
    
}
