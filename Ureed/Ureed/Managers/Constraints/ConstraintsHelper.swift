//
//  ConstraintsHelper.swift
//  Ureed
//
//  Created by Amjad Private on 8/10/17.
//  Copyright © 2017 Ureed. All rights reserved.
//

import UIKit
import Cartography

class ConstraintsHelper: NSObject {
    
    class func addEqualViewsConstrint(subView:UIView,superView:UIView,childSize:CGSize = .zero){
        
        if childSize == .zero {
            constrain(subView,superView){ subView,superView in
                subView.left  == superView.left
                subView.right == superView.right
                subView.top == superView.top
                subView.bottom == superView.bottom
            }
        }else {
             constrainToCenter(parent: superView, child: subView, childSize: childSize)
        }
        
    }
    
    class func constaintViewToLeft(view:UIView){
        view.superview?.addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: view.superview, attribute: .centerX, multiplier: 1, constant: 0))
        view.superview?.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view.superview, attribute: .width, multiplier: 1, constant: 0))
        view.superview?.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: view.superview, attribute: .centerY, multiplier: 1, constant: 0))
        view.superview?.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: view.superview, attribute: .height, multiplier: 1, constant: 0))
    }
    
    class func constrainToCenter(parent:UIView,child:UIView,childSize:CGSize? = nil,widthMultiplayer:CGFloat = 1,heightMultiplayer:CGFloat = 1){
        
        constrain(parent,child,replace:ConstraintGroup(), block: {parent,child in
            
            if let size = childSize {
                child.width == size.width * widthMultiplayer
                child.height == size.height * heightMultiplayer
            }
            
            
            child.centerX == parent.centerX
            child.centerY == parent.centerY
            
        })
    }
    
    
    class func constraintWithPadding(parent:UIView,child:UIView,padding:UIEdgeInsets,height:CGFloat)->NSLayoutConstraint?{
        var constraint:NSLayoutConstraint?
        constrain(child,parent, block: {child,parent in
            child.width == parent.width - padding.left  - padding.right
            child.centerX == parent.centerX
            child.top == parent.top + padding.top
            constraint = child.height == height
        })
        
        return constraint
    }
    
    
    class func constraintToLeft(superView:UIView,childView:UIView,childSize:CGSize,leftMargin:CGFloat = 0){

        constrain(superView,childView,replace:ConstraintGroup(), block: {superView,childView in

            childView.width == childSize.width
            childView.height == childSize.height
            childView.centerY == superView.centerY
            childView.left == superView.left + leftMargin
        })
        
    }
    


}
