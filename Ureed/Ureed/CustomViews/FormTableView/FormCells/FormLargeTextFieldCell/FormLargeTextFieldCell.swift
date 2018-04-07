//
//  FormLargeTextFieldCell.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/23/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

let FormLargeTextFieldCellId = "FormLargeTextFieldCell"
let FormLargeTextFieldCellNibName = "FormLargeTextFieldCell"
let FormLargeTextFieldCellHeight : CGFloat = 137
let FormLargeTextFieldCellHeightWithError : CGFloat = 160

class FormLargeTextFieldCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: BaseLabel!
    @IBOutlet weak var textView: BaseTextView!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textView.text = ""
        textView.addDoneToolbar = true
        textView.autocorrectionType = .no
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var title:String? = nil {
        didSet{
            textView.accessibilityLabel = title
            textView.accessibilityIdentifier = title
            titleLabel.text = title
        }
    }
    
    var textValue:String? = nil {
        didSet{
            textView.text = textValue ?? ""
        }
    }
    
    var validationMessage:String? = nil {
        didSet{
            errorLabel.text = validationMessage
        }
    }
    
    var keyboardType : UIKeyboardType = .default {
        didSet{
            textView.keyboardType = keyboardType
        }
    }
    
    var becomeTextFieldFirstResponder : Bool = false {
        didSet{
            if becomeTextFieldFirstResponder {
                self.textView.becomeFirstResponder()
            }
        }
    }
    
    var returnKey : UIReturnKeyType = .default {
        didSet{
            self.textView.returnKeyType = returnKey
        }
    }
}
