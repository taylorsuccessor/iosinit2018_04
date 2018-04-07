//
//  UIImageExtensions.swift
//  GameGo
//
//  Created by Amjad Tubasi on 12/11/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    public func changeTintColor(color: UIColor) -> UIImage {
        var newImage = self.withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(self.size, false, newImage.scale)
        color.set()
        newImage.draw(in: CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height))
        newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    public func changeColor(color: UIColor) -> UIImage {
        let backgroundSize = self.size
        UIGraphicsBeginImageContext(backgroundSize)
        guard let context = UIGraphicsGetCurrentContext() else {
            return self
        }
        var backgroundRect = CGRect()
        backgroundRect.size = backgroundSize
        backgroundRect.origin.x = 0
        backgroundRect.origin.y = 0
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        context.setFillColor(red: red, green: green, blue: blue, alpha: alpha)
        context.translateBy(x: 0, y: backgroundSize.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.clip(to: CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height),
                     mask: self.cgImage!)
        context.fill(backgroundRect)
        
        var imageRect = CGRect()
        imageRect.size = self.size
        imageRect.origin.x = (backgroundSize.width - self.size.width) / 2
        imageRect.origin.y = (backgroundSize.height - self.size.height) / 2
        
        context.setBlendMode(.multiply)
        context.draw(self.cgImage!, in: imageRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    public convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }
}
