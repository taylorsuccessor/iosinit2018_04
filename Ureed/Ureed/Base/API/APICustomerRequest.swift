//
//  APICustomerRequest.swift
//  Ureed
//
//  Created by Amjad Private on 3/5/18.
//  Copyright © 2018 Ureed. All rights reserved.
//

import UIKit

class APICustomerRequest: APIRequestBase {

    var cityId:Int?
    
    override init() {
        super.init()
//        cityId = User.current?.city?.id
    }
    
    override func queryStringParams() -> [String : Any] {
        var params = super.queryStringParams()
        if let cityId = cityId {
            params["cityId"] = cityId
        }
        return params
    }
}
