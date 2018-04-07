//
//  DropDownListView.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/20/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit
import DropDown

typealias DropDownSelectionAction = (Int,String)->()

class DropDownListView {

    class func initDropDown(){
        DropDown.startListeningToKeyboard()
    }
    
    fileprivate var dropDown:DropDown
    
    init() {
        self.dropDown = DropDown()
        self.dropDown.direction = .any
    }
    
    var anchorView : UIView? = nil {
        didSet{
            dropDown.anchorView = anchorView
        }
    }
    
    
    var list = [String]() {
        didSet{
            dropDown.dataSource = list
        }
    }
    
    var selectionAction : DropDownSelectionAction? = nil {
        didSet{
            dropDown.selectionAction =  { [unowned self] (index: Int, item: String) in
               self.selectionAction?(index,item)
            }
        }
    }
    
    
    func show(){
        dropDown.show()
    }
    
    func hide(){
        dropDown.hide()
    }
    
}
