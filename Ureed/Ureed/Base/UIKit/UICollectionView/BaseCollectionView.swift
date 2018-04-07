//
//  BaseCollectionView.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/3/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll
import Util

enum NoDataViewType {
    case none
    case favorites
    case productsHistory
    case searchResults(query:String)
    var view : UIView? {
        switch self {
//        case .favorites:
//            return UIView.favoritesNoDataView()
//        case .productsHistory:
//            return UIView.historyNoDataView()
//        case .searchResults(let query):
//            return UIView.searchResultsNoDataView(query: query)
//        case .inventory(let status):
//            return UIView.inventoryNoDataView(status: status)
//        case .orders(let status):
//            return UIView.ordersNoDataView(status: status)
        default:
            return nil
        }
    }
}

protocol ScrollLoadMoreDelegate {
    func didStartInfiniteScroll()
}

protocol UICollectionViewRefreshControlDelegate {
    func startRefreshing(for tableView:BaseCollectionView)
}

protocol UICollectionViewCellActionsDelegate {
    func cellActions(for collectionView:UICollectionView,at indexPath:IndexPath)->[CellAction]
}

struct CellAction {
    var title:String = ""
    var titleColor = UIColor.black
    var backgroundColor = UIColor.random()
    var handler:CompletionHandler
}

class BaseCollectionView: UICollectionView {

    var totalPages = 0
    var pageNumber = 0
    var loadMoreDelegate:ScrollLoadMoreDelegate?

    func registerCell(nibName:String,Id:String){
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: Id)
    }
    
    func registerHeader(nibName:String,Id:String){
        self.register(UINib(nibName: nibName, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Id)
    }
    
    func registerFooter(nibName:String,Id:String){
        self.register(UINib(nibName: nibName, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: Id)
    }
    
    var isLoadMoreEnabled : Bool = true

    func setupLoadMore(pageNumber:Int,totalPages:Int) {
        self.pageNumber = pageNumber
        self.totalPages = totalPages
        self.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        self.addInfiniteScroll { [weak self] (scrollView) -> Void in
            self?.pageNumber += 1
            self?.loadMoreDelegate?.didStartInfiniteScroll()
        }
        self.setShouldShowInfiniteScrollHandler({ [unowned self] (scrollView) -> Bool in
            return self.totalPages > self.pageNumber && self.isLoadMoreEnabled
        })
    }
    
    fileprivate var refreshDelegate:UICollectionViewRefreshControlDelegate?

    lazy var collectionRefreshControl: UIRefreshControl = {
        let refresh =  UIRefreshControl()
        refresh.accessibilityLabel = "PULL_TO_REFRESH"
        refresh.accessibilityIdentifier = "PULL_TO_REFRESH"
        return refresh
    }()
    
    
    func addRefreshControl(delegate:UICollectionViewRefreshControlDelegate?,tintColor:UIColor? = nil,attributedTitle:NSAttributedString? = nil){
        if let attributedString = attributedTitle {
            self.collectionRefreshControl.attributedTitle = attributedString
        }
        if let refreshTintColor = tintColor {
            self.collectionRefreshControl.tintColor = refreshTintColor
        }
        
        self.refreshDelegate = delegate
        self.collectionRefreshControl.addTarget(self, action: #selector(self.startRefreshing), for: .valueChanged)
        self.addSubview(collectionRefreshControl)
    }
    
    @objc func startRefreshing(){
        refreshDelegate?.startRefreshing(for: self)
    }
    
    func deleteItem(at indexPath:IndexPath,completion:CompletionHandler? = nil){
        self.performBatchUpdates({
            self.deleteItems(at: [indexPath])
        }, completion:{completed in
            if completed {
                self.reloadData()
                completion?()
            }
        })
    }
    
    var noDataView:UIView?
    
    func showNoDataView(type:NoDataViewType){
        guard let view = type.view else {return}
        if noDataView != nil {
            noDataView!.removeFromSuperview()
        }
        
        noDataView = view
        noDataView!.frame = self.bounds
        self.addSubview(noDataView!)
        noDataView!.bringSubview(toFront: self)
//        _ = noDataView!.addHeightConstraint(toView: self)
//        _ = noDataView!.addWidthConstraint(toView: self)
//        updateConstraints()
//        layoutIfNeeded()
    }
    
    func hideNoDataView(){
        noDataView?.removeFromSuperview()
    }
    
}
