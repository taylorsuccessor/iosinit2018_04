//
//  StringExtensions.swift
//  Util
//
//  Created by Amjad Private on 3/10/18.
//  Copyright © 2018 GameGo. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    
    public var urlEncodedString : String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    public var localized:String{
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    public var isValidPassword : Bool {
        return self.count > 5 && self.count <= 32
    }
    
    public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    public func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    public func trimLeadingZeroes() -> String {
        let cleaned = self.matchesForRegexInText("^0*").first ?? ""
        return self.replacingOccurrences(of: cleaned, with: "")
    }
    
    
    public func formatPhone(dialCode:String)->String{
        guard !self.isBlank else {return self}
        let value = self.replacedArabicDigitsWithEnglish.trimLeadingZeroes().removeAllSpaces().removeSpecialChars()
        
        if value.hasPrefix(dialCode){
            let number = value.stringByReplacingFirstOccurrenceOfString(dialCode, withString: "")
            return "\(dialCode)\(number)"
        }
        return "\(dialCode)\(value)"
    }
    
    public func removeHTML()->String{
        return self.replacingOccurrences(of:"<[^>]+>" , with: "", options: .regularExpression, range: nil)
    }
    public func removeAllSpaces()->String{
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    public func removeSpecialChars() -> String {
        let unsafeChars = CharacterSet.alphanumerics.inverted  // Remove the .inverted to get the opposite result.
        return self.components(separatedBy: unsafeChars).joined(separator: "")
    }
    public var replacedArabicDigitsWithEnglish: String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    public func stringByReplacingFirstOccurrenceOfString(_
        target: String, withString replaceString: String) -> String
    {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }
    
    
}

public extension Optional where Wrapped == String {
    public var isBlank: Bool {
        return self?.isBlank ?? true
    }
}

