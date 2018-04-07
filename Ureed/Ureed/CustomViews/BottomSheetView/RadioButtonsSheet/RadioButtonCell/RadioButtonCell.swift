//
//  RadioButtonCell.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/7/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

let RadioButtonCellId = "RadioButtonCell"
let RadioButtonCellNibName = "RadioButtonCell"
let RadioButtonCellHeight : CGFloat = 44

class RadioButtonCell: BaseTableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var labelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var title:String? = nil {
        didSet{
            titleLabel.text = title
        }
    }
    
    var isChoiceSelected : Bool = false {
        didSet {
            self.accessoryType = isChoiceSelected ? .checkmark : .none
        }
    }
    
    var imageUrl:String? = nil {
        didSet{
            guard let url = imageUrl , !url.isBlank else {
                labelLeftConstraint.constant = 16
                return
            }
            labelLeftConstraint.constant = 50
            ImageLoaderHelper.loadImage(url: url, into: iconImageView, pleacholder: .country)
        }
    }
}
