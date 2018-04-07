//
//  WidgetItem.swift
//  Ureed
//
//  Created by Amjad Tubasi on 2/11/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import Foundation
import UIKit

enum WidgetStatus : Equatable {
    
    case pending(loadingSize:CGSize)
    case fetchedEmpty(emptyWidgetStatment:String?)
    case fetched
    static func ==(lhs: WidgetStatus, rhs: WidgetStatus) -> Bool {
        switch (lhs,rhs) {
        case (.fetched,.fetched):
            return true
        case (.fetchedEmpty(let emptyWidgetStatment),.fetchedEmpty(let emptyWidgetStatment2)):
            return emptyWidgetStatment == emptyWidgetStatment2
        case (.pending(let size1),.pending(let size2)):
            return size1 == size2
        default:
            return false
        }
    }
    
}

protocol Widget {
    
    func prepareWidget(_ collectionView:BaseCollectionView)
    func numberOfItems(_ collectionView:BaseCollectionView,at section:Int)->Int
    func cellForItem(_ collectionView:BaseCollectionView,at indexPath:IndexPath)->BaseCollectionViewCell
    func sizeForItem(_ collectionView:BaseCollectionView,at indexPath:IndexPath)->CGSize
    func widgetPadding(_ collectionView:BaseCollectionView,at section:Int)->UIEdgeInsets
    func widgetMargins(_ collectionView:BaseCollectionView,at section:Int)->Margins
    func didSelectWidgetItem(_ collectionView:BaseCollectionView,at indexPath:IndexPath)
    var status : WidgetStatus {get}
    
    func viewForHeader(_ collectionView:BaseCollectionView,at indexPath:IndexPath)->UICollectionReusableView
    func sizeForHeader(_ collectionView:BaseCollectionView,at section:Int)->CGSize

    
    func viewForFooter(_ collectionView:BaseCollectionView,at indexPath:IndexPath)->UICollectionReusableView
    func sizeForFooter(_ collectionView:BaseCollectionView,at section:Int)->CGSize
    
    func titleForHeader(_ collectionView:BaseCollectionView,at section:Int)->String?

}

extension Widget {
    
    func viewForHeader(_ collectionView:BaseCollectionView,at indexPath:IndexPath)->UICollectionReusableView {return UICollectionReusableView()}
    func sizeForHeader(_ collectionView:BaseCollectionView,at section:Int)->CGSize{return .zero}

    func viewForFooter(_ collectionView:BaseCollectionView,at indexPath:IndexPath)->UICollectionReusableView {return UICollectionReusableView()}
    func sizeForFooter(_ collectionView:BaseCollectionView,at section:Int)->CGSize{return .zero}
    func titleForHeader(_ collectionView:BaseCollectionView,at section:Int)->String? {return nil}
    func didSelectWidgetItem(_ collectionView:BaseCollectionView,at indexPath:IndexPath){}
    
    func widgetPadding(_ collectionView:BaseCollectionView,at section:Int)->UIEdgeInsets{return .zero}
    func widgetMargins(_ collectionView:BaseCollectionView,at section:Int)->Margins {return (vertical:0,horizantal:0)}

}
