//
//  WidgetsCollectionView.swift
//  Ureed
//
//  Created by Amjad Tubasi on 2/12/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit

class WidgetsCollectionView: BaseCollectionView {

    //MARK: Public Vars

    var widgets = [Widget]() {
        didSet{
            widgets.forEach({$0.prepareWidget(self)})
        }
    }
    
    //MARK: init

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupWidgetCollection()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupWidgetCollection()
    }
    
    private func setupWidgetCollection(){
        self.registerCell(nibName: WidgetLoadingCellNibName, Id: WidgetLoadingCellId)
        self.registerCell(nibName: WidgetEmptyCellNibName, Id: WidgetEmptyCellId)
        self.registerHeader(nibName: WidgetTitleHeaderNibName, Id: WidgetTitleHeaderId)
        self.dataSource = self
        self.delegate = self
    }
    
}

//MARK: Data Source

extension WidgetsCollectionView : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return widgets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch widgets[section].status {
        case .pending:
            return 1
        case .fetchedEmpty(let emptyStatment):
            return emptyStatment.isBlank ? 0 : 1
        default:
            return widgets[section].numberOfItems(self, at: section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch widgets[indexPath.section].status {
        case .pending:
            return collectionView.dequeueReusableCell(withReuseIdentifier: WidgetLoadingCellId, for: indexPath)
        case .fetchedEmpty(let emptyStatment):
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: WidgetEmptyCellId, for: indexPath) as! WidgetEmptyCell
            cell.emptyWidgetLabel.text = emptyStatment
            return cell
        default:
            return widgets[indexPath.section].cellForItem(self, at: indexPath)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        switch widgets[indexPath.section].status {
        case .pending(let size):
            return size
        case .fetchedEmpty(let emptyStatment):
            return emptyStatment.isBlank ? .zero : CGSize(width: collectionView.w, height: WidgetEmptyCellHeight)
        default:
            return widgets[indexPath.section].sizeForItem(self, at: indexPath)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch widgets[section].status {
        case .fetchedEmpty(let emptyStatment):
            if emptyStatment.isBlank {
                return .zero
            }
            break
        default:
            break
        }
        
        if let _ = widgets[section].titleForHeader(self, at: section) {
            return CGSize(width: collectionView.w, height: WidgetTitleHeaderHeight)
        }
        return widgets[section].sizeForHeader(self, at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch widgets[section].status {
        case .fetchedEmpty,.pending:
            return .zero
        default:
            break
        }
        return widgets[section].sizeForFooter(self, at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        switch widgets[indexPath.section].status {
        case .fetchedEmpty(let emptyStatment):
            if emptyStatment.isBlank {
                return UICollectionReusableView()
            }
            break
        default:
            break
        }
       
        
        guard kind == UICollectionElementKindSectionHeader else {
            return widgets[indexPath.section].viewForFooter(self, at: indexPath)
        }
        
        guard let title = widgets[indexPath.section].titleForHeader(self, at: indexPath.section) else {
            return widgets[indexPath.section].viewForHeader(self, at: indexPath)
        }
        
        let titleView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: WidgetTitleHeaderId, for: indexPath) as! WidgetTitleHeader
        titleView.titleLabel.text = title
        return titleView

    }
}

//MARK: Flow Delegate

extension WidgetsCollectionView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return widgets[section].widgetPadding(self, at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return widgets[section].widgetMargins(self, at: section).vertical
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return widgets[section].widgetMargins(self, at: section).horizantal
    }
}

//MARK: Delegate

extension WidgetsCollectionView : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        widgets[indexPath.section].didSelectWidgetItem(self, at: indexPath)
    }
}
