//
//  FormRowItem.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/19/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

protocol FormItemValidation {
    func validationMessage(for item:FormRowItem)->String?
}

enum FormRowItemValidation : Equatable {
    
    static func ==(lhs: FormRowItemValidation, rhs: FormRowItemValidation) -> Bool {
        switch (lhs,rhs) {
        case (.optional,.optional):
            return true
        case (.mandatory,.mandatory):
            return true
        case (.customValidations,.customValidations):
            return true
        default:
            return false
        }
    }
    
    case optional
    case mandatory(validationMessage:String)
    case customValidations(customValidationDelegate:FormItemValidation)
}

enum FormRowItemType : String {
    case unknown        = ""
    case textField      = "textfield"
    case dropDown       = "dropdown"
    case switchField    = "switch"
    case phoneTextField = "phoneNumber"
    case addressPicker  = "address_picker"
    case textView       = "textview"
    case largeTextField = "large_textfield"

    static func from(string:String?)->FormRowItemType{
        return FormRowItemType(rawValue: string ?? "") ?? .unknown
    }
    
    func formItem(title:String?,validations:String?,tag:Int,value:Any?,country:String = "")->FormRowItem?{
        var item = FormRowItem()
        switch self {
        case .textField:
            item =  TextFieldFormRowItem(title: title, value: value as? String)
        case .dropDown:
            item =  DropDownFormRowItem(title: title, list: value as? [String])
        case .switchField:
            item = SwitchFieldFormRowItem(title: title, state: value as? Bool ?? false)
        case .phoneTextField:
            item = PhoneTextFieldRowItem(country: country, phoneNumber: value as? String)
        case .addressPicker:break
//            item = AddressPickerFormRowItem(title: title, addresses: [])
        case .textView:
            item = TextViewFormRowItem(attributedText: nil)
        case .largeTextField:
            item = LargeTextFieldFormRowItem(title: title, value: value as? String)
        default:
            return nil
        }
        if let validation = validations , !validation.isBlank {
            item.itemValidation = .mandatory(validationMessage: validation)
        }else {
            item.itemValidation = .optional
        }
        
        item.integerTag = tag
        
        return item
    }
    
}

protocol  FormRowItemActions {
    func shouldReload(item:FormRowItem)
    func foucsOnNextItem(currentItem:FormRowItem)
    func tableViewFrame()->CGRect
}

class FormRowItem: NSObject , FormItemRowDataSource , FormItemRowDelegate {

    var itemValue:Any?{
        get{return nil}
    }
    
    var integerTag = 0
    
    var itemValidation : FormRowItemValidation = .optional
    var validationMessage:String?
    var formRowItemActions:FormRowItemActions?
    var shouldFoucsOnItem = false
    var isLastItem = false
    var isHidden = false
    var type:FormRowItemType = .unknown
    var isDisabled = false
    var useCustomValidations = false
    
    func perpareItemRow(for formTableView:FormTableView){
        fatalError("should override perpareItemRow")
    }
    
    func cellForItemRow(for formTableView: FormTableView, at indexPath: IndexPath) -> BaseTableViewCell {
        fatalError("should override cellForItemRow")
    }
    
    func heightForItemRow(for formTableView: FormTableView, at indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    func isFormItemRowHidden(for formTableView: FormTableView, at indexPath: IndexPath) -> Bool {
        return isHidden
    }
    
    func isFormItemRowValidToSubmit(for formTableView:FormTableView,at indexPath:IndexPath)->Bool{
        return false
    }
}
