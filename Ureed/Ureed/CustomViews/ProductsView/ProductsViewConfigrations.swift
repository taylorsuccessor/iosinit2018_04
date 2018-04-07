//
//  ProductsViewConfigrations.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/3/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import Foundation
import UIKit

enum ProductsLayoutType {
    case list
    case listWithRemove
    case offerDetails
    
    static let values = [ProductsLayoutType.list,ProductsLayoutType.listWithRemove,ProductsLayoutType.offerDetails]
    
    var cellIdentitifier : String {
        switch self {
        case .list:
            return "ProductsViewListCell"
        case .listWithRemove:
            return "ProductsViewListWithRemoveCell"
        case .offerDetails:
            return "ProductsViewFullDetailCell"
        }
    }
    
    var cellNibName : String {
        switch self {
        case .list:
            return "ProductsViewListCell"
        case .listWithRemove:
            return "ProductsViewListWithRemoveCell"
        case .offerDetails:
            return "ProductsViewFullDetailCell"
        }
    }
    
    var titleFont : UIFont {
        switch self {
        case .list,.listWithRemove,.offerDetails:
            return UIFont.systemFont(ofSize: 16)
        }
    }
    
    var defaultHeight : CGFloat {
        switch self {
        case .list,.listWithRemove:
            return 84
        case .offerDetails:
            return 99
        }
    }
    
    var titleRightPadding : CGFloat {
        switch self {
        case .list,.listWithRemove:
            return 54
        case .offerDetails:
            return 8
        }
    }
}

protocol ProductsViewDataSource {
    func numberOfProductsSections(in view:ProductsView,for collectionView:UICollectionView)->Int
    func numberOfProducts(_ view:ProductsView,for collectionView:UICollectionView,at section:Int)->Int
    func productImageUrl(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)->String?
    func productTitle(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)->String?
    func productEAN(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)->String?
    func productsViewLayout(in view:ProductsView,for collectionView:UICollectionView,at section:Int)->ProductsLayoutType
    
    //MARK: Optional Methods
    
    func isProductInFavorites(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)->Bool
    func offerSKU(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)->String?
    func offerPrice(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)->String?
    func offerQuantity(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)->String?

}

extension ProductsViewDataSource {
    func numberOfProductsSections(in view:ProductsView,for collectionView:UICollectionView)->Int {return 1}
    func isProductInFavorites(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)->Bool {return false}
    
    func offerSKU(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)->String?{return nil}
    func offerPrice(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)->String?{return nil}
    func offerQuantity(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)->String?{return nil}

}

protocol ProductsViewDelegate {
    func didSelectProduct(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)
    func productsSectionPaddings(in view:ProductsView,for collectionView:UICollectionView,at section:Int)->UIEdgeInsets
    func productsSectionMargins(in view:ProductsView,for collectionView:UICollectionView,at section:Int)->Margins
    func didMoveUp(in view:ProductsView,for collectionView:UICollectionView)
    func didMoveDown(in view:ProductsView,for collectionView:UICollectionView)
    func didSelectAddToFavorites(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)
    func didSelectShowProductInfo(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)
    func didSelectRemoveProduct(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath)

}

extension ProductsViewDelegate {
    func productsSectionPaddings(in view:ProductsView,for collectionView:UICollectionView,at section:Int)->UIEdgeInsets {return .zero}
    func productsSectionMargins(in view:ProductsView,for collectionView:UICollectionView,at section:Int)->Margins {return (vertical:0,horizantal:0)}
    func didMoveUp(in view:ProductsView,for collectionView:UICollectionView){}
    func didMoveDown(in view:ProductsView,for collectionView:UICollectionView){}
    func didSelectAddToFavorites(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath){}
    func didSelectShowProductInfo(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath){}
    func didSelectRemoveProduct(in view:ProductsView,for collectionView:UICollectionView,at indexPath:IndexPath){}
}
