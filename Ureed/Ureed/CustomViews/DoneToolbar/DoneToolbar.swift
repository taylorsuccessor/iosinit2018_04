//
//  DoneToolbar.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/20/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

class DoneToolbar: UIToolbar {


    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(target:Any?,action:Selector?){
        self.init(frame: CGRect(x: 0, y: 0, w: UIScreen.main.bounds.width, h: 50))
        self.barStyle = .default
        let items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                     UIBarButtonItem(barButtonSystemItem: .done, target: target, action: action)]
        self.items = items
        self.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
