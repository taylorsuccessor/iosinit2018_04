//
//  FormAddressPickerCell.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/11/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

let FormAddressPickerCellId = "FormAddressPickerCell"
let FormAddressPickerCellNibName = "FormAddressPickerCell"
let FormAddressPickerCellHeight : CGFloat = 149

protocol FormAddressPickerCellDelegate {
    func didTapChangeAddress(in cell:FormAddressPickerCell,at indexPath:IndexPath)
}

class FormAddressPickerCell: BaseTableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate:FormAddressPickerCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = UIColor.clear
        containerView.addTapGesture(action: {_ in
            self.delegate?.didTapChangeAddress(in: self, at: self.indexPath)
        })
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        containerView.makeDashedBorder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func changeAddressAction(_ sender: Any) {
        self.delegate?.didTapChangeAddress(in: self, at: self.indexPath)
    }
    
    var formattedAddress:String? = nil {
        didSet{
            addressLabel.text = formattedAddress
        }
    }
    
    var title:String? = nil {
        didSet{
            titleLabel.text = title
        }
    }
    
    var buttonTitle:String? = nil {
        didSet{
            changeButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    var descriptionColor:UIColor = UIColor.black {
        didSet{
            addressLabel.textColor = descriptionColor
        }
    }
}
