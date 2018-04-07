//
//  FormToggleCell.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/21/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

let FormToggleCellId = "FormToggleCell"
let FormToggleCellNibName = "FormToggleCell"
let FormToggleCellHeight : CGFloat = 44

protocol FormToggleCellDelegate {
    func didChangeSwitchState(in cell:FormToggleCell,isOn:Bool)
}

class FormToggleCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: BaseLabel!
    @IBOutlet weak var switchView: BaseSwitch!
    
    var delegate:FormToggleCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func changeSwitchValueAction(_ sender: Any) {
        delegate?.didChangeSwitchState(in: self, isOn: switchView.isOn)
    }
    
    var title:String? = nil {
        didSet{
            titleLabel.text = title
        }
    }
    
    var switchState : Bool = false {
        didSet{
            switchView.isOn = switchState
        }
    }
}
