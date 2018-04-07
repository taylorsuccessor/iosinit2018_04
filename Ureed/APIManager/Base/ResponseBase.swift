//
//  ResponseBase.swift
//  APIManager
//
//  Created by Amjad Tubasi-Ureed on 12/3/17.
//  Copyright © 2017 Amjad Tubasi-Ureed. All rights reserved.
//

import UIKit
import ObjectMapper

open class ResponseBase: NSObject , Mappable {
    
    open var statusCode:Int = HTTPStatusCodes.InternalServerError.rawValue
    open var errorMessage:String?
    open var responseHeaders:[String:Any]?

    open func mapping(map: Map) {
        errorMessage <- map["meta.message"]
    }
    
    required public init?(map: Map){}
    public override init(){}
    
    var isRequestSuccess : Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
    public var eTagResponseHeader : String? {
        return responseHeaders?["Etag"] as? String
    }
}
