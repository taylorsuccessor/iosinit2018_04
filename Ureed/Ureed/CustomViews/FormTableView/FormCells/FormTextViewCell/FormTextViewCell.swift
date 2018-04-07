//
//  FormTextViewCell.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/14/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

let FormTextViewCellNibName = "FormTextViewCell"
let FormTextViewCellId = "FormTextViewCell"


class FormTextViewCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    var attributedText : NSAttributedString? = nil {
        didSet{
            titleLabel.text = nil
            titleLabel.attributedText = attributedText
        }
    }
}
