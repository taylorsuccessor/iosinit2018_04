//
//  DropDownFormRowItem.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/20/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

protocol DropDownSelectionDelegate {
    func didSelectItem(in field:DropDownFormRowItem,at index:Int,item:String)
}

class DropDownFormRowItem: FormRowItem {

    var title:String?
    var list:[String]?
    var selectedIndex:Int?
    var selectionAction:DropDownSelectionDelegate?
    
    convenience init(title:String?,list:[String]?,selectedIndex:Int? = nil){
        self.init()
        self.title = title
        self.list = list
        self.selectedIndex = selectedIndex
        self.type = .dropDown
    }
    
    override func perpareItemRow(for formTableView: FormTableView) {
        formTableView.registeCell(nibName: FormDropDownCellNibName, Id: FormDropDownCellId)
    }
    
    override func cellForItemRow(for formTableView: FormTableView, at indexPath: IndexPath)->BaseTableViewCell {
        let cell = formTableView.dequeueReusableCell(withIdentifier: FormDropDownCellId, for: indexPath) as! FormDropDownCell
        cell.list = list
        cell.title = title
        cell.delegate = self
        cell.validationMessage = validationMessage
        if let index = selectedIndex {
            cell.selectedItemString = list?[index]
        }else {
            cell.selectedItemString = nil
        }
        if shouldFoucsOnItem {
            shouldFoucsOnItem = false
            cell.dropDownList?.show()
        }
        return cell
    }
    
    override func heightForItemRow(for formTableView: FormTableView, at indexPath: IndexPath)->CGFloat {
        return  validationMessage == nil ? FormDropDownCellHeight : FormDropDownCellHeightWithError
    }
    
    override func isFormItemRowValidToSubmit(for formTableView: FormTableView, at indexPath: IndexPath) -> Bool {
        guard itemValidation != .optional else {return true}
        let isValid = isValidDropDownField()
        formTableView.reloadData()
        return isValid
    }
    
    override var itemValue: Any? {
        get{return selectedIndex}
    }
    
    private func isValidDropDownField()->Bool{
        if let value = itemValue as? Int , value < list?.count ?? 0 {
            validationMessage = nil
            return true
        }else if case .mandatory(let message) = itemValidation {
            validationMessage = message
            return false
        }
        return false
    }
    
    func clearSelection(){
        self.selectedIndex = nil
        self.formRowItemActions?.shouldReload(item: self)
    }
}

extension DropDownFormRowItem : FormDropDownCellDelegate {
    
    func didSelectFromDropDown(for cell: FormDropDownCell, dropDownView: DropDownListView?, Index: Int, item: String) {
        self.selectedIndex = Index
        self.validationMessage = nil
        self.formRowItemActions?.shouldReload(item: self)
        self.selectionAction?.didSelectItem(in: self, at: Index, item: item)
    }
    
}
