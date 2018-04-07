//
//  APIResponseBase.swift
//  UreedSeller
//
//  Created by Amjad Tubasi-Ureed on 12/5/17.
//  Copyright © 2017 Amjad Tubasi-Ureed. All rights reserved.
//

import UIKit
import APIManager
import ObjectMapper


enum APIResponseStatus {
    case success
    case error(NSError)
}

class APIResponseBase: ResponseBase {

    var response = ""
    var message:String?
    var status:APIResponseStatus = .success
    var totalPages = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        statusCode <- map["meta.status"]
        response <- map["meta.response"]
        message <- map["meta.message"]
        totalPages <- map["meta.pages"]
        if let success = map["success"].currentValue as? Bool {
            status = success ? .success : .error(NSError(domain: "Ureed.com", code: 200, userInfo: ["message":map["error"].currentValue as? String ?? ""]))
        }
    }
    
//    required init?(map: Map) {
//
//    }
    
    init(error:NSError) {
        super.init()
        self.status = .error(error)
    }
    
    required init?(map: Map) {
        super.init()
    }
    override init() {
        super.init()
    }
}
