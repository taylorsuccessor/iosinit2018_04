//
//  RequestBase.swift
//  APIManager
//
//  Created by Amjad Tubasi-Ureed on 12/3/17.
//  Copyright © 2017 Amjad Tubasi-Ureed. All rights reserved.
//

import UIKit

public typealias MultipartFormData = (data:Data,fileName:String,mimeType:String)

public protocol RequestBase  {
    
    func pathForRequest()->String
    func queryStringParams()->[String:Any]
    func bodyParams()->[String:Any]
    func requestHeaders()->[String:Any]
    func httpMethod()->HttpMethod
    func requstTimeout()->TimeInterval
    func version()->APIVersion?
    func baseUrl()->String?
    func useDefaultQueryParams()->Bool
    func downloadedFileName()->String?
    func multiPartFormData()->[MultipartFormData]?
}

public extension RequestBase {
    
    func queryStringParams()->[String:Any]{
        return [:]
    }
    
    func requestHeaders()->[String:Any]{
        return [:]
    }
    
    func bodyParams()->[String:Any]{
        return [:]
    }
    
    func httpMethod()->HttpMethod {
        return .GET
    }
    
    func requstTimeout()->TimeInterval {
        return defaultTimeout
    }
    
    func version()->APIVersion? {
        return .version2
    }
    
    func baseUrl()->String? {
        return nil
    }
    
    func useDefaultQueryParams()->Bool {
        return true
    }
    
    func downloadedFileName()->String? {
        return nil
    }
    
    func multiPartFormData()->[MultipartFormData]? {
        return nil
    }
}
