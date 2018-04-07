//
//  ProductLayoutHelper.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/3/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

typealias Margins = (vertical:CGFloat,horizantal:CGFloat)

class ProductLayoutHelper: NSObject {

    class func calculteProductItemSize(in view:ProductsView,layout:ProductsLayoutType,title:String?,hasActions:Bool = false,padding:UIEdgeInsets = .zero ,margins:Margins = (vertical:0,horizantal:0))->CGSize {
        
        guard let title = title , !title.isBlank else  { return CGSize(width: view.frame.width, height: layout.defaultHeight)}
        let titleRightPadding : CGFloat = layout.titleRightPadding
        
        
        let imageSize = CGSize(width: view.frame.width * 0.2, height: view.frame.width * 0.2)
        let imageLeftPadding : CGFloat = 13
        let imageRightPadding : CGFloat = 8
        
        let imageTopAndBottomMargins : CGFloat = 16
        let eanLabelHeight : CGFloat = 20
        let eanBottomMarging : CGFloat = 8
        let constrainedWidth : CGFloat = max(view.frame.width - imageLeftPadding - imageRightPadding - titleRightPadding - imageSize.width,0)
        let titleHeight = title.height(withConstrainedWidth: constrainedWidth , font: layout.titleFont)

        let seperatorHeight : CGFloat = 1
        
        var totalHeight : CGFloat = 0
        totalHeight += titleHeight
        totalHeight += imageTopAndBottomMargins
        totalHeight += eanLabelHeight
        totalHeight += eanBottomMarging
        totalHeight += seperatorHeight

//        return CGSize(width: view.frame.width, height: max(totalHeight,layout.defaultHeight))
//        var totalHeight = imageSize.height + imageTopAndBottomMargins + seperatorHeight
//        if titleHeight > imageSize.height {
//            totalHeight += titleHeight - imageSize.height + eanLabelHeight + eanBottomMarging
//        }else if imageSize.height - titleHeight < eanLabelHeight + eanBottomMarging {
//            totalHeight += eanBottomMarging
//        }
        
        
        switch layout {
         case .list,.listWithRemove:
            return CGSize(width: view.frame.width, height: max(totalHeight,layout.defaultHeight))
        case .offerDetails:
            let offerDetailsRowHeight : CGFloat = 20
            let offerDetailsRowMarging : CGFloat = 16

            let actionsHeightWithPadding : CGFloat = 30

            totalHeight += offerDetailsRowHeight
            totalHeight += offerDetailsRowMarging
            totalHeight += hasActions ? actionsHeightWithPadding  : 0 // actions options view

            
            return CGSize(width: view.frame.width, height: max(totalHeight,layout.defaultHeight))
        }
    }
}
