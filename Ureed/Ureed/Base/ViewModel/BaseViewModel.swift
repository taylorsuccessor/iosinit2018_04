//
//  BaseViewModel.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/7/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

class BaseViewModel: NSObject {

    var errorAction:Action?
    var error:NSError?
    var errorMessage:String?
    var pageNumber = 1
    var totalPages = 0

    override init() {
        
    }
    
    init(error:NSError?) {
        self.error = error
        self.errorAction = ErrorManager.errorAction(for: error)
        self.errorMessage = error?.userInfo["message"] as? String
    }
}
