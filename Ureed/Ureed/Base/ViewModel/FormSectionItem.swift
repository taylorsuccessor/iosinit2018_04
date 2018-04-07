//
//  FormSectionItem.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/10/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

class FormSectionItem: NSObject {
    
    var title:String?
    var rows = [FormRowItem]()
    
    init(title:String?,rows :[FormRowItem]) {
        self.title = title
        self.rows = rows
    }
}
