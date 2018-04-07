//
//  WidgetButtonCell.swift
//  Ureed
//
//  Created by Amjad Tubasi on 2/15/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

let WidgetButtonCellId = "WidgetButtonCell"
let WidgetButtonCellNibName = "WidgetButtonCell"
let WidgetButtonCellHeight : CGFloat = 65

protocol WidgetButtonCellDelegate {
    func didTapButton(in cell:WidgetButtonCell,sender:UIButton)
}

class WidgetButtonCell: BaseCollectionViewCell {

    @IBOutlet weak var button: UIButton!
    
    var delegate:WidgetButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        button.addShadow(offset: CGSize(width: 0, height: 1), radius: 3, color: UIColor.lightGray, opacity: 1)
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        delegate?.didTapButton(in: self, sender: button)
    }
    
}
