//
//  UIStoryboardExtensions.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/11/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import Foundation
import UIKit

enum UIStoryboardScreen : String {
    case unknown                 = ""
    case sideMenu                = "SideMenuVC"
    case dashboard               = "DashboardVC"
    case dashboardNavigation     = "DashboardNavVC"
    case menuNavigation          = "MenuNavigatorVC"
    case settingsNavigation      = "SettingsListNavVC"
    case changePassword          = "ChangePasswordVC"
    case addressList             = "AddressListVC"
    case settingsActions         = "SettingsActionsVC"
    case favroitesAndHistoryTabs = "FAV_HISTORY_PRODUCTS"
    case inventoryNavigation     = "InventoryTabsNavVC"
    case feedbackNavigation      = "FeedbackNavVC"
    case orderManagmentNavigation = "OrderManagmentNavVC"
    case orderReturnsNavVC        = "OrderReturnsNavVC"
    case withdrawalStatusNavTabsVC = "WithdrawalStatusNavTabsVC"
    
    static func from(string:String?)->UIStoryboardScreen{
        return UIStoryboardScreen(rawValue: string ?? "") ?? .unknown
    }
}

extension UIStoryboard {
    
    static func viewController(for Id:UIStoryboardScreen)->UIViewController? {
        guard Id != .unknown else {return nil}
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Id.rawValue)
    }
    
}
