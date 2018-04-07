//
//  ActionManager.swift
//  Ureed
//
//  Created by Amjad Private on 2/19/18.
//  Copyright © 2018 Ureed. All rights reserved.
//

import UIKit

enum Action {
    case none
    case showAlert(message:String)
}

class ActionManager: NSObject {

    class func perform(action:Action?){
        guard let action = action else {return}
        switch action {
        case .showAlert(let message):
            UIAlertController.showDefaultAlert(message: message)
            default:break
        }
    }
}
