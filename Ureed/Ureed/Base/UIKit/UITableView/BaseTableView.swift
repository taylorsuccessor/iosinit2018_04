//
//  BaseTableView.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/18/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

protocol UITableViewRefreshControlDelegate {
    func startRefreshing(for tableView:BaseTableView)
}

class BaseTableView: UITableView {
    
    fileprivate lazy var tableRefreshControl: UIRefreshControl = {
        let refresh =  UIRefreshControl()
        refresh.accessibilityLabel = "PULL_TO_REFRESH"
        refresh.accessibilityIdentifier = "PULL_TO_REFRESH"
        return refresh
    }()
    
    fileprivate var refreshDelegate:UITableViewRefreshControlDelegate?
    
    func registeCell(nibName:String,Id:String){
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: Id)
    }
    
    func registerHeader(nibName:String,Identifier:String){
        self.register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: Identifier)
    }
    
    func addRefreshControl(delegate:UITableViewRefreshControlDelegate?,tintColor:UIColor? = nil,attributedTitle:NSAttributedString? = nil){
        if let attributedString = attributedTitle {
            self.tableRefreshControl.attributedTitle = attributedString
        }
        if let refreshTintColor = tintColor {
            self.tableRefreshControl.tintColor = refreshTintColor
        }
        
        self.refreshDelegate = delegate
        self.tableRefreshControl.addTarget(self, action: #selector(self.startRefreshing), for: .valueChanged)
        if #available(iOS 10.0, *) {
            self.refreshControl = tableRefreshControl
        } else {
            self.addSubview(tableRefreshControl)
        }
    }
    
    @objc func startRefreshing(){
        refreshDelegate?.startRefreshing(for: self)
    }
    
    override func reloadData() {
        super.reloadData()
        self.tableRefreshControl.endRefreshing()
    }
    
    func finishInfiniteScrolling(){
        self.finishInfiniteScroll()
    }
    
    var totalPages = 0
    var pageNumber = 0
    var loadMoreDelegate:ScrollLoadMoreDelegate?
    
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
    }
    
    func hideNoDataView(){
        noDataView?.removeFromSuperview()
    }
}
