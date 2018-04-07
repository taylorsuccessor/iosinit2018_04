//
//  PhoneTextFieldRowItem.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/24/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit
import Util

class PhoneTextFieldRowItem: TextFieldFormRowItem {

    var countryCode:String = ""
    var dialCode = ""
    
    init(country code:String,phoneNumber:String?) {
        super.init()
        self.countryCode = code
        self.value = phoneNumber
        self.dialCode = Util.dialCode(for: countryCode)
    }
    
    override func perpareItemRow(for formTableView: FormTableView) {
        formTableView.registeCell(nibName:FormPhoneNumberCellNibName , Id: FormPhoneNumberCellId)
    }
    
    override func heightForItemRow(for formTableView: FormTableView, at indexPath: IndexPath)->CGFloat {
        return  validationMessage == nil ? FormPhoneNumberCellHeight : FormPhoneNumberCellHeightWithError
    }
    
    override func cellForItemRow(for formTableView: FormTableView, at indexPath: IndexPath)->BaseTableViewCell {
        let cell = formTableView.dequeueReusableCell(withIdentifier: FormPhoneNumberCellId, for: indexPath) as! FormPhoneNumberCell
        cell.delegate = self
        cell.phoneNumber = value
        cell.validationMessage = validationMessage
        if shouldFoucsOnItem {
            shouldFoucsOnItem = false
            cell.becomeTextFieldFirstResponder = true
        }
        cell.returnKey = isLastItem ? .done : .next
        cell.dialCode = dialCode
        
        return cell
    }
    
    override func isValidTextField()->Bool {
        if let value = itemValue as? String , !value.isBlank , Util.isValidPhoneNumber(phone: value, countryCode: countryCode) {
            validationMessage = nil
            return true
        }
        else if case .mandatory(let message) = itemValidation {
            validationMessage = message
            return false
        }
        
        return false
    }
}
