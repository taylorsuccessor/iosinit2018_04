//
//  ErrorManager.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/7/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit
import APIManager

class ErrorManager: NSObject {

    class func errorAction(for error:NSError?)->Action {
        guard let error = error else {return .none}
        let errorMessage = error.userInfo["message"] as? String
        
        
        switch HTTPStatusCodes.from(int: error.code) {
        case .InternalServerError:
            return Action.showAlert(message: errorMessage ?? "INTERNAL_SERVCER_ERROR".localized)
//        case .NotFound:
//            return Action.showAlert(message: "SERVICE_NOT_FOUND")
        case .UnprocessableEntity:
            return Action.showAlert(message: errorMessage ?? "WRONG_CREDTIONALS".localized)
        default:
            if let message = errorMessage {
                return Action.showAlert(message: message)
            }
            return .none
        }
    }
    
    
}
