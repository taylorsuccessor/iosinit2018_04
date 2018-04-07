//
//  TextViewFormRowItem.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/14/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

let FormTextViewCellTopAndBottomMargins : CGFloat = 32

class TextViewFormRowItem: FormRowItem {

    var attributedText:NSAttributedString? = nil {
        didSet{
            guard let tableFrame = formRowItemActions?.tableViewFrame()  ,let attributedText = attributedText else {return}
            textHeight = attributedText.height(withConstrainedWidth: tableFrame.width) + FormTextViewCellTopAndBottomMargins
            formRowItemActions?.shouldReload(item: self)
        }
    }
    
    fileprivate var textHeight : CGFloat = 0
    
    convenience init(attributedText:NSAttributedString?) {
        self.init()
        self.attributedText = attributedText
    }
    
    override func perpareItemRow(for formTableView: FormTableView) {
        formTableView.registeCell(nibName: FormTextViewCellNibName, Id: FormTextViewCellId)
    }
    
    override func cellForItemRow(for formTableView: FormTableView, at indexPath: IndexPath)->BaseTableViewCell {
        let cell = formTableView.dequeueReusableCell(withIdentifier: FormTextViewCellId, for: indexPath) as! FormTextViewCell
        cell.attributedText = attributedText
        return cell
    }
    
    override func heightForItemRow(for formTableView: FormTableView, at indexPath: IndexPath)->CGFloat {
        return  textHeight
    }
    
    override func isFormItemRowValidToSubmit(for formTableView: FormTableView, at indexPath: IndexPath) -> Bool {
        return true
    }
    
    override var itemValue: Any? {
        get{return nil}
    }
    
}
