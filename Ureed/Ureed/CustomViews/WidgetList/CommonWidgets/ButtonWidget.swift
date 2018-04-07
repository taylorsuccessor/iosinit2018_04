//
//  ButtonWidget.swift
//  Ureed
//
//  Created by Amjad Tubasi on 2/15/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit
import Util

class ButtonWidget: NSObject , Widget {
    
    var isEnabled = true
    var title:String?
    var actionCompletion:CompletionHandler?
    
    func prepareWidget(_ collectionView: BaseCollectionView) {
        collectionView.registerCell(nibName: WidgetButtonCellNibName, Id: WidgetButtonCellId)
    }
    
    func numberOfItems(_ collectionView: BaseCollectionView, at section: Int) -> Int {
        return 1
    }
    
    func cellForItem(_ collectionView: BaseCollectionView, at indexPath: IndexPath) -> BaseCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WidgetButtonCellId, for: indexPath) as! WidgetButtonCell
        cell.button.setTitle(title, for: .normal)
        cell.button.isEnabled = isEnabled
        cell.delegate = self
        return cell
    }
    
    func sizeForItem(_ collectionView: BaseCollectionView, at indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.w, height: WidgetButtonCellHeight)
    }
    
    var status: WidgetStatus {
        if let _ = title {
            return .fetched
        }
        return .pending(loadingSize: .zero)
    }
}

extension ButtonWidget : WidgetButtonCellDelegate {
    func didTapButton(in cell: WidgetButtonCell, sender: UIButton) {
        actionCompletion?()
    }
}
