//
//  APIError.swift
//  APIManager
//
//  Created by Amjad Tubasi-Ureed on 12/3/17.
//  Copyright © 2017 Amjad Tubasi-Ureed. All rights reserved.
//

import UIKit

public enum  ErrorCode : Int {
    case invalidURL = 1
    case invalidHttpMethod
    case invalidSerilization
}

public enum ErrorDomain : String {
    case requestError = "com.Ureed.seller.request.error"
    case responseError = "com.Ureed.seller.response.error"
}
