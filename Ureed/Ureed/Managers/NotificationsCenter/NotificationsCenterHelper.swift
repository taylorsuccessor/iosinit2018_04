//
//  NotificationsCenterHelper.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/24/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let submitNewAddress = Notification.Name(rawValue: "submitNewAddress")
    static let verifyAddress = Notification.Name(rawValue: "verifyAddress")
    static let editOffer = Notification.Name(rawValue: "editOffer")
    static let feedbackReply = Notification.Name(rawValue: "feedbackReply")
    static let changeOrderStatus = Notification.Name(rawValue: "changeOrderStatus")
}


class NotificationsCenterHelper: NSObject {

    
    class func post(name:Notification.Name,object:Any? = nil,userInfo:[String:Any]? = nil){
        NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
    }
    
    class func startListening(to name:Notification.Name,at observer:Any,selector:Selector){
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: nil)
    }
}

