//
//  BaseTableViewCell.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/11/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    var disbleView:UIView?
    var useDisableView = false
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.clipsToBounds = true
        self.contentView.clipsToBounds = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard useDisableView else {return}
        disbleView = UIView(superView: self)
        disbleView!.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        disbleView!.isHidden = true
        self.addSubview(disbleView!)
        self.bringSubview(toFront: disbleView!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    var isDisabled : Bool = false {
        didSet{
            disbleView?.isHidden = !isDisabled
        }
    }
}
