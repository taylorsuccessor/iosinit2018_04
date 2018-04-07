//
//  WidgetEmptyCell.swift
//  Ureed
//
//  Created by Amjad Tubasi on 2/15/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

let WidgetEmptyCellId = "WidgetEmptyCell"
let WidgetEmptyCellNibName = "WidgetEmptyCell"
let WidgetEmptyCellHeight : CGFloat = 100

class WidgetEmptyCell: BaseCollectionViewCell {

    @IBOutlet weak var emptyWidgetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
