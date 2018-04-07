//
//  DateExtensions.swift
//  Ureed
//
//  Created by Amjad Tubasi on 2/18/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import Foundation

public extension Date {
    
    public static func toString(timestamp:Int,format:String)->String{
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp / 1000))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
