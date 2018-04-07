//
//  FloatingTabsController.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/7/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit
import CarbonKit

struct TabInfo {
    var title:String
    var viewController:UIViewController
    init(title:String,viewController:UIViewController) {
        self.title = title
        self.viewController = viewController
    }
}

protocol FloatingTabsDelegate {
    func floatingTabs(_ floatingTabs:FloatingTabsController,didMoveAt index:Int)
    func floatingTabs(_ floatingTabs:FloatingTabsController,willMoveAt index:Int)
}

class FloatingTabsController: NSObject {

    var items = [TabInfo]()
    var delegate:FloatingTabsDelegate?
    fileprivate var carbonTabSwipeNavigation:CarbonTabSwipeNavigation!
    
    init(items:[TabInfo]) {
        super.init()
        self.prepareTabs(items: items)
    }

    fileprivate func prepareTabs(items:[TabInfo]){
        guard !items.isEmpty else {return}
        self.items = items
        self.carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items.flatMap({$0.title}), delegate: self)
        self.carbonTabSwipeNavigation.setTabExtraWidth(30)
        self.carbonTabSwipeNavigation.setIndicatorColor(UIColor.blue)
        self.carbonTabSwipeNavigation.setNormalColor(UIColor.black)
        self.carbonTabSwipeNavigation.setSelectedColor(UIColor.blue)
    }
    
    func insert(into viewController:UIViewController,targetView:UIView? = nil){
        if let view = targetView {
            carbonTabSwipeNavigation.insert(intoRootViewController: viewController, andTargetView: view)
        }else {
            carbonTabSwipeNavigation.insert(intoRootViewController: viewController)
        }
    }
    
    func updateTabs(items:[TabInfo],into viewController:UIViewController){
        carbonTabSwipeNavigation.willMove(toParentViewController: nil)
        carbonTabSwipeNavigation.view.removeFromSuperview()
        carbonTabSwipeNavigation.removeFromParentViewController()
        prepareTabs(items: items)
        insert(into: viewController)
    }
    
    var currentTabIndex : Int {
        get {
            return carbonTabSwipeNavigation.currentTabIndex.toInt
        }set {
            guard newValue < items.count else {return}
            carbonTabSwipeNavigation.setCurrentTabIndex(UInt(newValue), withAnimation: false)
        }
    }
}

extension FloatingTabsController : CarbonTabSwipeNavigationDelegate {
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        return items[index.toInt].viewController
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
        delegate?.floatingTabs(self, didMoveAt: index.toInt)
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, willMoveAt index: UInt) {
        delegate?.floatingTabs(self, willMoveAt: index.toInt)
    }
    
}
