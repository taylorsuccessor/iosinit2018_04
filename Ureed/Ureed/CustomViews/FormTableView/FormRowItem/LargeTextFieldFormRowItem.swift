//
//  LargeTextFieldFormRowItem.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/23/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

class LargeTextFieldFormRowItem: TextFieldFormRowItem {

    override init() {
        super.init()
    }
    
    override func perpareItemRow(for formTableView: FormTableView) {
        formTableView.registeCell(nibName: FormLargeTextFieldCellNibName, Id: FormLargeTextFieldCellId)
    }
    
    override func cellForItemRow(for formTableView: FormTableView, at indexPath: IndexPath)->BaseTableViewCell {
        let cell = formTableView.dequeueReusableCell(withIdentifier: FormLargeTextFieldCellId, for: indexPath) as! FormLargeTextFieldCell
        cell.textView.delegate = self
        cell.textValue = value
        cell.title = title
        cell.validationMessage = validationMessage
        cell.keyboardType = keyboardType
        if shouldFoucsOnItem {
            shouldFoucsOnItem = false
            cell.becomeTextFieldFirstResponder = true
        }
        cell.returnKey = .default
        return cell
    }
    
    override func heightForItemRow(for formTableView: FormTableView, at indexPath: IndexPath)->CGFloat {
        return  validationMessage == nil ? FormLargeTextFieldCellHeight : FormLargeTextFieldCellHeightWithError
    }
}

extension LargeTextFieldFormRowItem : UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        _ = isValidTextField()
        self.formRowItemActions?.shouldReload(item: self)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.value = textView.text
    }

}
