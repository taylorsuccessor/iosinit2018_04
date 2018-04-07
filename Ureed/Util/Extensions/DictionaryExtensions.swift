//
//  DictionaryExtensions.swift
//  APIManager
//
//  Created by Amjad Tubasi-Ureed on 12/3/17.
//  Copyright © 2017 Amjad Tubasi-Ureed. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    public var urlString : String {
        var urlString = ""
        let sortedDic = self.sorted { (aDic, bDic) -> Bool in
            let key1 = aDic.key as? String ?? ""
            let key2 = bDic.key as? String ?? ""
            return key1 < key2
        }
        for (paramNameObject, paramValueObject) in sortedDic {
            let paramNameEncoded = (paramNameObject as? String)?.urlEncodedString
            let paramValueEncoded = "\(paramValueObject)".urlEncodedString
            var oneUrlPiece = ""
            if let nameEncoded = paramNameEncoded {
                oneUrlPiece = "\(nameEncoded)=\(paramValueEncoded)"
            }
            urlString = urlString + (urlString == "" ? "" : "&") + oneUrlPiece
        }
        
        return urlString
    }
    
    public static func += (lhs: inout Dictionary, rhs: Dictionary) {
        lhs.merge(rhs) { (_, new) in new }
    }
    
    public mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
    
    public func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
    
}
