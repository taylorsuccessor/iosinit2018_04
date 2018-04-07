//
//  FormTableView.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/19/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

protocol FormItemRowDataSource {
    func perpareItemRow(for formTableView:FormTableView)
    func cellForItemRow(for formTableView:FormTableView,at indexPath:IndexPath)->BaseTableViewCell
    func heightForItemRow(for formTableView:FormTableView,at indexPath:IndexPath)->CGFloat
    func isFormItemRowValidToSubmit(for formTableView:FormTableView,at indexPath:IndexPath)->Bool
}

protocol FormItemRowDelegate {
    func isFormItemRowHidden(for formTableView:FormTableView,at indexPath:IndexPath)->Bool
}

class FormTableView: BaseTableView {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
        self.separatorStyle = .none
//        self.backgroundColor = UIColor.lightGray
        self.registerHeader(nibName: FormSectionViewNibName, Identifier: FormSectionViewId)
        self.addTapGesture(action: {_ in
            self.endEditing(true)
        })
    }
    
    var formSections = [FormSectionItem](){
        didSet{
            formSections.forEach({section in
                section.rows.forEach({$0.perpareItemRow(for: self)
                    $0.formRowItemActions = self
                })
            })
            formSections.last?.rows.last?.isLastItem = true
        }
    }
    
//    var formItems = [FormRowItem]() {
//        didSet{
//            formItems.forEach({$0.perpareItemRow(for: self)
//                $0.formRowItemActions = self
//            })
//            formItems.last?.isLastItem = true
//        }
//    }
    
    override func reloadData() {
        //super.reloadData()
        let contentOffset = self.contentOffset
        super.reloadData()
        self.layoutIfNeeded()
        self.setContentOffset(contentOffset, animated: false)
    }
    
    func fieldItem(for tag:Int)->FormRowItem? {
        for section in formSections {
            if let item = section.rows.first(where: {$0.integerTag == tag}) {
                return item
            }
        }
        return nil
    }
    
    func textFieldItem(for tag:Int)->TextFieldFormRowItem? {
        return fieldItem(for: tag) as? TextFieldFormRowItem
    }
    
    func dropDownItem(for tag:Int)->DropDownFormRowItem? {
        return fieldItem(for: tag) as? DropDownFormRowItem
    }
    
    func switchItem(for tag:Int)->SwitchFieldFormRowItem? {
        return fieldItem(for: tag) as? SwitchFieldFormRowItem
    }
    
    func phoneNumberItem(for tag:Int)->PhoneTextFieldRowItem? {
        return fieldItem(for: tag) as? PhoneTextFieldRowItem
    }
    
    func textViewItem(for tag:Int)->TextViewFormRowItem? {
        return fieldItem(for: tag) as? TextViewFormRowItem
    }
    
//    func addressPickerItem(for tag:Int)->AddressPickerFormRowItem? {
//        return fieldItem(for: tag) as? AddressPickerFormRowItem
//    }
    
    func textFieldValue(for tag:Int)->String? {
        return fieldItem(for: tag)?.itemValue as? String
    }
    
//    func mobileValue(for tag:Int)->MobileFieldValue? {
//        return fieldItem(for: tag)?.itemValue as? MobileFieldValue
//    }
    
    func dropDownValue(for tag:Int)->Int?{
        return fieldItem(for: tag)?.itemValue as? Int
    }
    
    func switchFieldValue(for tag:Int)->Bool {
        return fieldItem(for: tag)?.itemValue as? Bool ?? false
    }
    
    func phoneNumberValue(for tag:Int)->String? {
        return fieldItem(for: tag)?.itemValue as? String
    }
    
    func isFormValidToSubmit()->Bool {
        
        for (sectionIndex,section) in formSections.enumerated() {
            for (index,element) in section.rows.enumerated() {
                guard element.isFormItemRowValidToSubmit(for: self, at: IndexPath(row: index, section: 0)) else {
                    self.scrollToRow(at:IndexPath(item: index, section: sectionIndex) , at: .middle, animated: true)
                    return false
                }
            }
        }
        
        return true
    }
    
    
}

extension FormTableView : UITableViewDataSource  , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return formSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formSections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = formSections[indexPath.section].rows[indexPath.row]
        let cell =  item.cellForItemRow(for: self, at: indexPath)
        cell.useDisableView = true
        cell.isDisabled = item.isDisabled
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = formSections[indexPath.section].rows[indexPath.row]

        guard !item.isFormItemRowHidden(for: self, at: indexPath) else {
            return 0
        }
        
        return item.heightForItemRow(for: self, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = formSections[section].title , !title.isBlank else {return nil}
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FormSectionViewId) as? FormSectionView else {return nil}
        headerView.title = title
        headerView.contentView.backgroundColor = tableView.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let title = formSections[section].title , !title.isBlank else {return 0}
        return FormSectionViewHeight
    }
}

extension FormTableView : FormRowItemActions {
    
    func tableViewFrame() -> CGRect {
        return self.frame
    }
    
    func foucsOnNextItem(currentItem: FormRowItem) {
        
        for section in formSections {
            if let currentItemIndex = section.rows.index(of: currentItem) , currentItemIndex < section.rows.count - 2 {
                section.rows.forEach({$0.shouldFoucsOnItem = false})
                section.rows[currentItemIndex + 1].shouldFoucsOnItem = true
                self.reloadData()
                return
            }
        }
    }
    
    func shouldReload(item: FormRowItem) {
        self.reloadData()
    }
    
}
