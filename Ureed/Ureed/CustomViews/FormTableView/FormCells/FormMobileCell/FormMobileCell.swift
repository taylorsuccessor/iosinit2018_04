//
//  FormMobileCell.swift
//  Ureed
//
//  Created by Amjad Private on 2/26/18.
//  Copyright © 2018 Ureed. All rights reserved.
//

import UIKit

let FormMobileCellNib = "FormMobileCell"
let FormMobileCellId = "FormMobileCell"
let FormMobileCellHeight : CGFloat = 56

protocol  FormMobileCellDelegate {
    func didTapChangeCountry(targetView:UIView)
}

class FormMobileCell: BaseTableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var mobileField: BaseTextField!
    @IBOutlet weak var dropdownIcon: UIImageView!
    @IBOutlet weak var countryFlagLabel: UIImageView!
    @IBOutlet weak var dialCodeLabel: UILabel!
    @IBOutlet weak var countryCodeView: UIView!
    
    var delegate:FormMobileCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countryCodeView.addTapGesture(action: {_ in
            self.delegate?.didTapChangeCountry(targetView: self.countryCodeView)
        })
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        mobileField.addBorderBottom(size: 1, color: UIColor(hexString: "EBEBF1") ?? UIColor.lightGray)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var country:Country? = nil {
        didSet{
            dialCodeLabel.text = "+" + (country?.dialCode ?? "")
            ImageLoaderHelper.loadImage(url: country?.imageUrl, into: flagImageView, pleacholder: .country)
        }
    }
    
}
