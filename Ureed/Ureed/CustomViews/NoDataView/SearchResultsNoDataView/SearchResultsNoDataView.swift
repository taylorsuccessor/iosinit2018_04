//
//  SearchResultsNoDataView.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/23/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

class SearchResultsNoDataView: BaseView {

    @IBOutlet weak var desriptionLabel: UILabel!
    
    var desrcptionValue : String? = nil {
        didSet{
            desriptionLabel.attributedText = nil
            desriptionLabel.text = desrcptionValue
        }
    }
    
    var desrcptionAttributedValue : NSMutableAttributedString? = nil {
        didSet{
            desriptionLabel.text = nil
            desriptionLabel.attributedText = desrcptionAttributedValue
        }
    }
}
