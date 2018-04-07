//
//  Prefrances.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/13/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit
import APIManager
import Util

enum Environment {
    case debug
    case production
    
    var apiVersion:APIVersion {
        switch self {
        case .debug:
            return .version1
        case .production:
            return .version1
        }
    }
    
    var baseUrl : String {
        switch self {
        case .debug:
            return "http://ec2-54-225-135-64.compute-1.amazonaws.com/Ureed/"
        case .production:
            return "http://ec2-54-225-135-64.compute-1.amazonaws.com/Ureed/"
        }
    }
}

class Prefrances: NSObject {

    class var baseUrl : String {
        return enviroment.baseUrl
    }
    
    class var javaBaseUrl : String {
        return Util.infoFor(key: Constants.kKeyJavaBaseUrl) ?? ""
    }
    
    class var defaultQueryParams : [String:Any]{
        var params = [String:Any]()
//        params[Constants.kKeyAppSecret] = Util.infoFor(key: Constants.kKeyAppSecret) ?? ""
//        params[Constants.kKeyAppId] = Util.infoFor(key: Constants.kKeyAppId) ?? ""
//        params[Constants.kKeyAppLanguage] = currentLanguage
        return params
    }
    
    class var enviroment : Environment {
        #if DEBUG
            return Environment.debug
        #else
            return Environment.production
        #endif
    }
    
    class var currentLanguage : String {
        return NSLocale.current.languageCode ?? "en"
    }
    
    class var deviceCountry : String {
        return Locale.current.regionCode ?? "jo"
    }
    
    class var copyRightsStatment : String {
        let year = Date().toString(format: "yyyy")
        return String(format: "Copyright © %@ Ureed. All right reserved".localized, year)
    }
    
    class var currencies : [String:(code: String, symbol: String)] {
        let currencies = Locale.isoRegionCodes.reduce(into: [String: (code: String, symbol: String)]()) {
            let locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: $1]))
            $0[$1] = (locale.currencyCode ?? "", locale.currencySymbol ?? "")
        }

        return currencies
    }
    
    class var currentCurrency : String? {
        return "JO"
    }
    
    class var profileImageCompresion : CGFloat {
        return 0.05
    }
}
