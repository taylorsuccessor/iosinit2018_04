//
//  UploadManager.swift
//  APIManager
//
//  Created by Amjad Tubasi-Ureed on 2/28/18.
//  Copyright © 2018 Amjad Tubasi-Ureed. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireObjectMapper

public extension APIManager {
    
    public func sendMultiPartDataRequest<T:ResponseBase>(_ requestObject:RequestBase,responseObject:T.Type ,completion:@escaping (ResponseBase?,NSError?)->()){
        
        guard let url = URL(string: self.fullUrl(for: requestObject)) else {
            completion(nil ,NSError(domain: ErrorDomain.requestError.rawValue, code: ErrorCode.invalidURL.rawValue, userInfo: nil))
            return
        }
        
        
        guard let method = HTTPMethod(rawValue: requestObject.httpMethod().rawValue) else {
            completion(nil, NSError(domain: ErrorDomain.requestError.rawValue, code: ErrorCode.invalidHttpMethod.rawValue, userInfo: nil))
            return
        }
        
        let headers = fullHeaders(for: requestObject.requestHeaders()) as? [String : String]
        
         manager!.upload(multipartFormData:{ multipartFormData in
            for (key, value) in requestObject.bodyParams() {
                if let data = value as? String {
                    multipartFormData.append((data.data(using: .utf8))!, withName: key)
                }else if let data = value as? Int {
                    multipartFormData.append((String(data).data(using: .utf8))!, withName: key)
                }                
            }
            
            if let files = requestObject.multiPartFormData() , !files.isEmpty {
                files.forEach({multipartFormData.append($0.data, withName: $0.fileName, fileName: $0.fileName, mimeType: $0.mimeType)})
            }
        },to:url,method:method,headers:headers){results in
            
            switch results {
            case .success(let upload, _, _):
                
                upload.responseObject(completionHandler: {(response: DataResponse<T>) in
                    self.handleResponse(response: response, completion: completion)
                })
                
                
                if self.logLevel == .verbose {
                    upload.responseString(completionHandler: {stringResponse in
                        print("*******************MultiPart Data CALL***************************")
                        print("\(method.rawValue):\(url)\n\nrequest Headers:\(headers ?? [:])\n\nrequest_body:\(requestObject.bodyParams())")
                        print("Response:\n\n\(stringResponse.result.value ?? "")")
                        print("******************************************************")
                    })
                }
                
                
            case .failure(let error):
                
                let nsError = NSError(domain: ErrorDomain.responseError.rawValue, code: 500, userInfo: ["message":error.localizedDescription])
                completion(nil,nsError)

            }
            
        }
        
        
            
            
        
        
    }
}
