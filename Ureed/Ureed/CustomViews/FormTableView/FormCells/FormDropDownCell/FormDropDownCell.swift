//
//  FormDropDownCell.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/20/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit


let FormDropDownCellId = "FormDropDownCell"
let FormDropDownCellNibName = "FormDropDownCell"
let FormDropDownCellHeightWithError : CGFloat = 104
let FormDropDownCellHeight : CGFloat = 85

protocol FormDropDownCellDelegate {
    func didSelectFromDropDown(for cell:FormDropDownCell,dropDownView:DropDownListView?,Index:Int,item:String)
}

class FormDropDownCell: BaseTableViewCell {

    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var dropDownListButton: BaseButton!
    @IBOutlet weak var dropDownTitleLabel: UILabel!
    
    var dropDownList:DropDownListView?
    var delegate:FormDropDownCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dropDownList = DropDownListView()
        self.dropDownListButton.setTitle("SELECT_NOW".localized, for: .normal)
        self.dropDownList?.anchorView = dropDownListButton
        self.dropDownList?.selectionAction = { index,string in
            self.delegate?.didSelectFromDropDown(for: self, dropDownView: self.dropDownList, Index: index, item: string)
            self.dropDownListButton.setTitle(string, for: .normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        dropDownListButton.addBorderBottom(size: 1, color: UIColor.lightGray)
    }
    
    @IBAction func dropDownAction(_ sender: Any) {
        dropDownList?.show()
    }
    
    var list : [String]?{
        didSet{
            dropDownList?.list = list ?? []
        }
    }
    
    var title:String? = nil {
        didSet{
            dropDownTitleLabel.text = title
        }
    }
    
    var selectedItemString:String? = nil {
        didSet{
            if let title = selectedItemString {
                self.dropDownListButton.setTitle(title, for: .normal)
                self.dropDownListButton.setTitleColor(UIColor.lightGray, for: .normal)
            }else {
                self.dropDownListButton.setTitle("SELECT_NOW".localized, for: .normal)
                self.dropDownListButton.setTitleColor(UIColor.lightGray
                    , for: .normal)
            }
        }
    }
    
    var validationMessage:String? = nil {
        didSet{
            validationLabel.text = validationMessage
        }
    }
    
    
}
