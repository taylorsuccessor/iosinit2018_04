//
//  DownloadManager.swift
//  APIManager
//
//  Created by Amjad Tubasi-Ureed on 2/15/18.
//  Copyright © 2018 Amjad Tubasi-Ureed. All rights reserved.
//

import Foundation
import Alamofire

extension APIManager {
    
    public func downloadFile(for requestObject:RequestBase,completion:@escaping (URL?,Data?,NSError?)->()){
        
        guard let url = URL(string: self.fullUrl(for: requestObject)) else {
            completion(nil,nil ,NSError(domain: ErrorDomain.requestError.rawValue, code: ErrorCode.invalidURL.rawValue, userInfo: nil))
            return
        }
        
        
        guard let method = HTTPMethod(rawValue: requestObject.httpMethod().rawValue) else {
            completion(nil,nil, NSError(domain: ErrorDomain.requestError.rawValue, code: ErrorCode.invalidHttpMethod.rawValue, userInfo: nil))
            return
        }
        
        let headers = fullHeaders(for: requestObject.requestHeaders()) as? [String : String]
        let encoding:URLEncoding = URLEncoding.default
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent(requestObject.downloadedFileName() ?? "")
            return (documentsURL, [.removePreviousFile])
        }
       //let destination = DownloadRequest.suggestedDownloadDestination()

        Alamofire.download(url, method: method, parameters: requestObject.bodyParams(), encoding: encoding, headers: headers, to: destination).responseData(completionHandler: {response in
            
            switch response.result {
            case .failure(let error):
                let nsError = NSError(domain: ErrorDomain.responseError.rawValue, code: response.response?.statusCode ?? 500, userInfo: ["message":error.localizedDescription])
                completion(nil,nil,nsError)
            case .success:
                completion(response.destinationURL,response.result.value,nil)
            }
        })
    }
    
}
