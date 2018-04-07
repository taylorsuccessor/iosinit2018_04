//
//  ProductsView.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/3/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit
import Util

class ProductsView: BaseView {

    @IBOutlet weak var collectionView: BaseCollectionView!
    
    var dataSource:ProductsViewDataSource! = nil {
        didSet{
            self.collectionView.dataSource = self
        }
    }
    
    var delegate:ProductsViewDelegate? = nil {
        didSet{
            self.collectionView.delegate = self
        }
    }
    
    var scrollDirection : UICollectionViewScrollDirection  = .vertical {
        didSet{
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
            }
        }
    }
    
    var scrollLoadMoreDelegate : ScrollLoadMoreDelegate? = nil {
        didSet{
            self.collectionView.loadMoreDelegate = scrollLoadMoreDelegate
        }
    }
    
    var totalPages : Int = 0 {
        didSet{
            self.collectionView.totalPages = totalPages
        }
    }
    
    var pageNumber : Int = 1 {
        didSet{
            self.collectionView.pageNumber = pageNumber
        }
    }
    
    var isRefreshing : Bool {
        return collectionView.collectionRefreshControl.isRefreshing
    }
    
    func endRefreshing(){
        guard isRefreshing else {return}
        collectionView.collectionRefreshControl.endRefreshing()
    }

    fileprivate var lastContentOffset: CGFloat = 0

    
    private func prepareView(){
        for value in ProductsLayoutType.values {
            self.collectionView.registerCell(nibName: value.cellNibName, Id: value.cellIdentitifier)
        }
    }
    
    override func xibSetup() {
        super.xibSetup()
        prepareView()
    }
    
    func reloadData(){
        self.collectionView.reloadData()
    }
    
    func reloadItem(indexPath:IndexPath){
        self.collectionView.reloadItems(at: [indexPath])
    }
    
    func invalidateView(){
        self.itemsHeights = [:]
        self.reloadData()
    }
    
    fileprivate var itemsHeights = [IndexPath:CGSize]()
    
    func finishInfiniteScroll(){
        self.collectionView.finishInfiniteScroll()
    }
    
    func setupLoadMore(pageNumber:Int,totalPages:Int){
        self.collectionView.setupLoadMore(pageNumber: pageNumber, totalPages: totalPages)
    }
    
    var isLoadMoreEnabled : Bool = true {
        didSet{
            self.collectionView.isLoadMoreEnabled = isLoadMoreEnabled
        }
    }
    
    func addPullToRefresh(delegate:UICollectionViewRefreshControlDelegate?){
        self.collectionView.addRefreshControl(delegate: delegate)
    }
    
    func deleteItem(at indexPath:IndexPath,completion:CompletionHandler? = nil){
        self.collectionView.deleteItem(at: indexPath,completion:completion)
    }
    
    func showNoDataView(for type:NoDataViewType){
        collectionView.showNoDataView(type: type)
    }
    
    func hideNoDataView(){
        collectionView.hideNoDataView()
    }
    
    var cellActionsDelegate : UICollectionViewCellActionsDelegate? = nil
}

extension ProductsView : UICollectionViewDataSource , UIScrollViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfProductsSections(in: self, for: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfProducts(self, for: collectionView, at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let layoutType  = dataSource.productsViewLayout(in: self, for: collectionView, at: indexPath.section)
        let cell        = collectionView.dequeueReusableCell(withReuseIdentifier: layoutType.cellIdentitifier, for: indexPath) as! ProductsViewCell
        cell.indexPath = indexPath
        cell.title      = dataSource.productTitle(in: self, for: collectionView, at: indexPath)
        cell.imageUrl   = dataSource.productImageUrl(in: self, for: collectionView, at: indexPath)
        cell.ean        = dataSource.productEAN(in: self, for: collectionView, at: indexPath)
        cell.isProductInFavorites = dataSource.isProductInFavorites(in: self, for: collectionView, at: indexPath)
        cell.sku          = dataSource.offerSKU(in: self, for: collectionView, at: indexPath)
        cell.price        = dataSource.offerPrice(in: self, for: collectionView, at: indexPath)
        cell.quantity     = dataSource.offerQuantity(in: self, for: collectionView, at: indexPath)
        cell.actions =    cellActionsDelegate?.cellActions(for: collectionView, at: indexPath) ?? []
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if let size = itemsHeights[indexPath] {
            return size
        }
        let layoutType  = dataSource.productsViewLayout(in: self, for: collectionView, at: indexPath.section)
        let title = dataSource.productTitle(in: self, for: collectionView, at: indexPath)
        let hasActions = !(cellActionsDelegate?.cellActions(for: collectionView, at: indexPath).isEmpty ?? true)
        let size = ProductLayoutHelper.calculteProductItemSize(in: self, layout: layoutType, title: title,hasActions: hasActions)
        itemsHeights[indexPath] = size
        return size
    }
    
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            // moved to top
            self.delegate?.didMoveUp(in: self, for: self.collectionView)
        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
            // moved to bottom
            self.delegate?.didMoveDown(in: self, for: self.collectionView)
        } else {
            // didn't move
        }
    }
}

extension ProductsView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return delegate?.productsSectionPaddings(in: self, for: collectionView, at: section) ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        
        return delegate?.productsSectionMargins(in: self, for: collectionView, at: section).vertical ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return delegate?.productsSectionMargins(in: self, for: collectionView, at: section).horizantal ?? 0
    }
}

extension ProductsView : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectProduct(in: self, for: collectionView, at: indexPath)
    }
}

extension ProductsView : ProductsViewCellDelegate {
    
    func didTapRemoveProductButton(in cell: ProductsViewCell, at indexPath: IndexPath) {
        delegate?.didSelectRemoveProduct(in: self, for: collectionView, at: indexPath)
    }
    
    func didTapAddToFavorites(in: ProductsViewCell, at indexPath: IndexPath) {
        delegate?.didSelectAddToFavorites(in: self, for: collectionView, at: indexPath)
    }
    
    func didTapShowProductInfo(in: ProductsViewCell, at indexPath: IndexPath) {
        delegate?.didSelectShowProductInfo(in: self, for: collectionView, at: indexPath)
    }
    
}
