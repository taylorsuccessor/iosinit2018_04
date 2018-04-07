//
//  Constants.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/13/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit
import EZSwiftExtensions

struct Constants {

    static let kKeyBaseUrl          = "BASE_URL"
    static let kKeyJavaBaseUrl      = "JAVA_BASE_URL"
    static let kKeyAppSecret        = "app_secret"
    static let kKeyAppId            = "app_id"
    static let kKeyEnvironment      = "Environment"
    static let kKeyAppLanguage      = "language"

    static let kKeyAppAbout                    = "ABOUT_APP"
    static let kKeyAppLogout                   = "APP_LOGOUT"
    static let kKeyAppHistoryAndPrivacy        = "HISTORY_PRIVACY"


    static let mobileRegex = "((00|\\+)\\d{1,3}[-\\.\\s]?)?\\d{2,3}[-\\.\\s]?\\d{3}[-\\.\\s]?\\d{3,5}"
    static let emailRegex = "(http[|s]?\\:\\\\)?([\\da-zA-Z\\.-]+)\\.([a-zA-Z\\.][a-zA-Z]{2,6}\\b)([\\/\\w \\.-]*)*\\/?"
    
}
