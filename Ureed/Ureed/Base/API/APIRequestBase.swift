//
//  APIRequestBase.swift
//  UreedSeller
//
//  Created by Amjad Tubasi-Ureed on 12/5/17.
//  Copyright © 2017 Amjad Tubasi-Ureed. All rights reserved.
//

import UIKit
import APIManager

class APIRequestBase:NSObject, RequestBase {
    
    var pageNumber = 1
    var show = 10

    override init() {
        
    }
    
    func pathForRequest() -> String {
        fatalError("should override pathForRequest")
    }
    
    func version() -> APIVersion? {
        return Prefrances.enviroment.apiVersion
    }
    
   
    func queryStringParams()->[String:Any]{
        return ["page":pageNumber,"pageSize":show]
    }
    
    func bodyParams()->[String:Any]{
        return [:]
    }
    
    func requestHeaders()->[String:Any]{
        return [:]
    }
    
    func httpMethod()->HttpMethod {
        return .GET
    }
    
    func requstTimeout()->TimeInterval {
        return defaultTimeout
    }
    
    func baseUrl() -> String? {
        return nil
    }
    
    func useDefaultQueryParams() -> Bool {
        return true
    }
    
    func downloadedFileName() -> String? {
        return nil
    }
    
    func legacyParams(for params:[String:Any])->String{
        var string = ""
        for (key,value) in params {
            string += "[\(key)=\(value)]"
        }
        return string
    }
    
    func multiPartFormData() -> [MultipartFormData]? {
        return nil
    }
}

