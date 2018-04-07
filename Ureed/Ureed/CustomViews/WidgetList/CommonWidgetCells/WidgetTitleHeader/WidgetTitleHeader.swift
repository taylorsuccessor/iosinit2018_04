//
//  WidgetTitleHeader.swift
//  Ureed
//
//  Created by Amjad Tubasi on 2/12/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

let WidgetTitleHeaderId = "WidgetTitleHeader"
let WidgetTitleHeaderNibName = "WidgetTitleHeader"
let WidgetTitleHeaderHeight : CGFloat = 50

class WidgetTitleHeader: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
