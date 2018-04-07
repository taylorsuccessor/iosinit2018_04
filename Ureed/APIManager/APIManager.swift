//
//  APIManager.swift
//  APIManager
//
//  Created by Amjad Tubasi-Ureed on 12/3/17.
//  Copyright © 2017 Amjad Tubasi-Ureed. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Util


public class APIManager: NSObject {
    
    //MARK: - Singlaton
    
    fileprivate override init() {}
    public static let sharedInstance = APIManager()
    
    //MARK: - Public Var

    public var logLevel:LogLevel = .none

    //MARK: - Private Var

    private var baseUrl : String = ""
    private var defaultHeaders = [String:Any]()
    private var defaultQueyStringParams = [String:Any]()

    
    //MARK: - Internal Var
    var manager:SessionManager?

    //MARK: - Private Methods

    private func initAlamofireManager(timeout:TimeInterval) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        self.manager =  Alamofire.SessionManager(configuration: configuration)
    }
    
    fileprivate func fullQueryStringParams(queryStringParams:[String:Any])->[String:Any]{
        return self.defaultQueyStringParams.merged(with: queryStringParams)
    }
    
    func fullUrl(for request:RequestBase)->String{
        var requestUrl = request.pathForRequest()
        
        if requestUrl.hasPrefix("/"){
            requestUrl.remove(at: requestUrl.startIndex)
        }
        
        if requestUrl.hasSuffix("/"){
            requestUrl.remove(at: requestUrl.endIndex)
        }
        
        if let serviceBaseUrl = request.baseUrl() , !serviceBaseUrl.isEmpty {
            requestUrl = "\(serviceBaseUrl)/" + requestUrl
        }else if let version = request.version() {
            requestUrl = self.baseUrl + "\(version.rawValue)/" + requestUrl
        }else {
            requestUrl = self.baseUrl + requestUrl
        }
        
        
        
        var merged = request.useDefaultQueryParams() ?  fullQueryStringParams(queryStringParams: request.queryStringParams()) : request.queryStringParams()
        
        if let signature = getSignature(for: request) {
            merged[kKeySignature] = signature
        }
        
        if !merged.isEmpty {
            requestUrl += "?" + merged.urlString
        }
        
        
        
        return requestUrl
    }
    
    func fullHeaders(for requestHeaders:[String:Any])->[String:Any]{
        return self.defaultHeaders.merged(with: requestHeaders)
    }
    
    //MARK: - Public Methods
    
    public func initAPIManager(baseUrl:String,defaultTimeOut:TimeInterval = defaultTimeout) {
        let base = baseUrl.hasSuffix("/") ? baseUrl : "\(baseUrl)/"
        self.baseUrl = base
        self.initAlamofireManager(timeout: defaultTimeOut)
    }
    
    public func setDefaultHeaders(defaultHeaders:[String:Any]) {
        self.defaultHeaders = defaultHeaders
    }
    
    public func setDefaultQueryStringParams(params:[String:Any]) {
        self.defaultQueyStringParams = params
    }
    
    public func setVersion(version:APIVersion){
        guard !self.baseUrl.isEmpty else {
            fatalError("init APIManager before set Version")
        }
    }
    
    public func sendRequest<T:ResponseBase>(for requestObject:RequestBase ,responseObject:T.Type ,completion:@escaping (ResponseBase?,NSError?)->()) {
        
        guard let url = URL(string: self.fullUrl(for: requestObject)) else {
            completion(nil, NSError(domain: ErrorDomain.requestError.rawValue, code: ErrorCode.invalidURL.rawValue, userInfo: nil))
            return
        }
        
        
        guard let method = HTTPMethod(rawValue: requestObject.httpMethod().rawValue) else {
            completion(nil, NSError(domain: ErrorDomain.requestError.rawValue, code: ErrorCode.invalidHttpMethod.rawValue, userInfo: nil))
            return
        }
        
        let headers = fullHeaders(for: requestObject.requestHeaders()) as? [String : String]
        let encoding:URLEncoding = URLEncoding.default
        
        let request = manager!.request(url, method: method, parameters: requestObject.bodyParams(), encoding: encoding, headers: headers).responseObject(completionHandler: {(response: DataResponse<T>) in
            
           self.handleResponse(response: response, completion: completion)
        })
        
        if self.logLevel == .verbose {
            request.responseString(completionHandler: {stringResponse in
                print("*******************API CALL***************************")
                print("\(method.rawValue):\(url)\n\nrequest Headers:\(headers ?? [:])\n\nrequest_body:\(requestObject.bodyParams())")
                print("Response:\n\n\(stringResponse.result.value ?? "")")
                print("******************************************************")
            })
        }
        
        
        
    }
    
    func handleResponse<T:ResponseBase>(response: DataResponse<T>,completion:@escaping (ResponseBase?,NSError?)->()){
        switch response.result {
        case .success(let value):
            
            let responseObject = value
            responseObject.statusCode = response.response?.statusCode ?? 500
            responseObject.responseHeaders = response.response?.allHeaderFields as? [String : Any]
            var nsError:NSError?
            if !responseObject.isRequestSuccess {
                nsError = NSError(domain: ErrorDomain.responseError.rawValue, code: responseObject.statusCode, userInfo: ["message":responseObject.errorMessage ?? ""])
            }
            completion(value,nsError)
        case .failure(let error):
            let nsError = NSError(domain: ErrorDomain.responseError.rawValue, code: response.response?.statusCode ?? 500, userInfo: ["message":error.localizedDescription])
            completion(nil,nsError)
        }
    }
}

//MARK: - Extensions

extension Date {
    
    func toString(withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let myString = formatter.string(from: self)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = format
        
        return formatter.string(from: yourDate!)
    }
}

extension APIManager {
    
    func getSignature(for request:RequestBase)->String?{
        return nil
//        guard let version = request.version() , version.useSingutre else {
//            return nil
//        }
//        
//        let queryStringParams = self.fullQueryStringParams(queryStringParams: request.queryStringParams())
//        let paramsToHash = queryStringParams.merged(with: request.bodyParams())
//        return paramsToHash.urlString.sha512(using: signatureHashKey)
    }

}
