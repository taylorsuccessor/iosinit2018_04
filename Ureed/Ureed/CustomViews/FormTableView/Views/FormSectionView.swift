//
//  FormSectionView.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/10/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

let FormSectionViewHeight : CGFloat = 60
let FormSectionViewId = "FormSectionView"
let FormSectionViewNibName = "FormSectionView"

class FormSectionView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!

    var title:String? = nil {
        didSet{
            titleLabel.text = title
        }
    }
}
