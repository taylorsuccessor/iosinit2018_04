//
//  SwitchFieldFormRowItem.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/21/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

class SwitchFieldFormRowItem: FormRowItem {

    var title:String?
    var state = false
    
    convenience init(title:String?,state:Bool) {
        self.init()
        self.title = title
        self.state = state
        self.type = .switchField
    }
    
    override func perpareItemRow(for formTableView:FormTableView){
        formTableView.registeCell(nibName: FormToggleCellNibName, Id: FormToggleCellId)
    }
    
    override func cellForItemRow(for formTableView: FormTableView, at indexPath: IndexPath) -> BaseTableViewCell {
        let cell = formTableView.dequeueReusableCell(withIdentifier: FormToggleCellId, for: indexPath) as! FormToggleCell
        cell.delegate = self
        cell.switchState = state
        cell.title = title
        return cell
    }
    
    override func heightForItemRow(for formTableView: FormTableView, at indexPath: IndexPath) -> CGFloat {
        return FormToggleCellHeight
    }
    
    override func isFormItemRowValidToSubmit(for formTableView:FormTableView,at indexPath:IndexPath)->Bool{
        return true
    }
    
    override var itemValue: Any? {
        get {return state}
    }
}

extension SwitchFieldFormRowItem : FormToggleCellDelegate {
    func didChangeSwitchState(in cell: FormToggleCell, isOn: Bool) {
        self.state = isOn
    }
}
