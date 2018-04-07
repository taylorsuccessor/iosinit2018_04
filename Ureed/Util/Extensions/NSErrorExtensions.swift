//
//  NSErrorExtensions.swift
//  GameGo
//
//  Created by Amjad Tubasi on 2/11/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import Foundation
public extension NSError {

    public class func error(for message:String)->NSError {
        return NSError(domain: "GameGo.com", code: 500, userInfo: ["message":message])
    }
    
    public class var `default` : NSError {
        return error(for: "DEFAULT_ERROR".localized)
    }
}
