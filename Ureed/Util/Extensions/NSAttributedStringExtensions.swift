//
//  NSAttributedStringExtensions.swift
//  GameGo
//
//  Created by Amjad Tubasi on 12/28/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import Foundation
import UIKit

public extension NSMutableAttributedString {
    
     @discardableResult public func bold(_ text:String) -> NSMutableAttributedString {
        let attrs = [NSAttributedStringKey.font :UIFont.boldSystemFont(ofSize: 20)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
     @discardableResult public func normal(_ text:String)->NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
    
     @discardableResult public func normalColored(_ text:String,color:UIColor = UIColor.black,fontSize:CGFloat = 12)->NSMutableAttributedString {
        let attrs = [NSAttributedStringKey.font :UIFont.systemFont(ofSize: fontSize),NSAttributedStringKey.foregroundColor : color]
        let normalColoredString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(normalColoredString)
        return self
    }
    
     @discardableResult public func boldColored(_ text:String,color:UIColor = UIColor.black,fontSize:CGFloat = 12)->NSMutableAttributedString {
        let attrs = [NSAttributedStringKey.font :UIFont.boldSystemFont(ofSize: fontSize),NSAttributedStringKey.foregroundColor : color]
        let boldColoredString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldColoredString)
        return self
    }
    
     @discardableResult public func newLine()->NSMutableAttributedString {
        let normal =  NSAttributedString(string: "\n")
        self.append(normal)
        return self
    }
    
     @discardableResult public func space()->NSMutableAttributedString {
        let normal =  NSAttributedString(string: " ")
        self.append(normal)
        return self
    }
    
     @discardableResult public func link(linkKeyWord:String,url:String)->NSMutableAttributedString {
        let foundRange = self.mutableString.range(of: linkKeyWord)
        self.addAttribute(NSAttributedStringKey.link, value: url, range: foundRange)
        return self
    }
    
     @discardableResult public func strikedColored(_ text:String,color:UIColor = UIColor.black,fontSize:CGFloat = 12) -> NSMutableAttributedString {
        
        //        let range = (self.string as NSString).range(of: text)
        let attributes = [
            NSAttributedStringKey.strikethroughStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int),NSAttributedStringKey.font :UIFont.systemFont(ofSize: fontSize),NSAttributedStringKey.foregroundColor:color,NSAttributedStringKey.baselineOffset:0] as [NSAttributedStringKey : Any]
        let strikedColored = NSMutableAttributedString(string:"\(text)", attributes:attributes)
        self.append(strikedColored)
        return self
    }
    
    public convenience init(aligment:NSTextAlignment) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = aligment
        self.init(string: "", attributes: [NSAttributedStringKey.paragraphStyle:aligment])
    }
    
    
}

public extension NSAttributedString {
    public func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    public func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}
