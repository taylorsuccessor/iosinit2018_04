//
//  UIViewExtensions.swift
//  GameGo
//
//  Created by Amjad Tubasi on 12/13/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
     @IBInspectable public var localization: String {
        get {
            return self.localization.localized
        }
        set {
            self.accessibilityIdentifier = newValue
            self.accessibilityLabel = newValue
            
            if let lable = self as? UILabel {
                lable.text = newValue.localized
            }else if let button = self as? UIButton {
                button.setTitle(newValue.localized, for: .normal)
            }else if let textField = self as? UITextField {
                textField.placeholder = newValue.localized
            }else if let textView = self as? UITextView {
                textView.text = newValue.localized
            }else if let searchBar = self as? UISearchBar {
                searchBar.placeholder = newValue.localized
            }
        }
    }
    
    @IBInspectable public var borderColor: UIColor {
        get {
            return self.borderColor
        }
        set {
            self.layer.masksToBounds = true
            self.layer.borderColor = newValue.cgColor
        }
    }
    
     @IBInspectable public var borderWidth: CGFloat {
        get {
            return self.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
     @IBInspectable public var roundedCorner: Bool {
        get {
            return self.roundedCorner
        }
        set {
            if newValue{
                self.layer.masksToBounds = true
                if let image = self as? UIImageView{
                    image.roundSquareImage()
                }else{
                    self.roundView()
                }
            }
        }
    }
    
     @IBInspectable public var cornerRadius : CGFloat {
        get{
            return self.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
    
     @IBInspectable public var shadow: Bool {
        get {
            return false
        }
        set {
            if newValue {
               self.addShadow(offset: CGSize(width: 0, height: 1), radius: 5, color: UIColor.lightGray, opacity: 1)
            }
        }
    }
    
    public func disableAllSubViews(){
        if self.subviews.count > 0 {
          self.subviews.forEach({$0.disableAllSubViews()})
        }else {
            switch self {
            case is UILabel:
                (self as? UILabel)?.textColor = UIColor.lightGray
            case is UIButton:
                (self as? UIButton)?.setTitleColor(UIColor.lightGray, for: .normal)
                (self as? UIButton)?.isEnabled = false
            case is UISwitch:
                (self as? UISwitch)?.tintColor = UIColor.lightGray
                (self as? UISwitch)?.isEnabled = false
            default:
                break
            }
           
        }
    }
    
   
    public func makeDashedBorder(strokeColor:UIColor = UIColor.lightGray)  {
        let mViewBorder = CAShapeLayer()
        mViewBorder.strokeColor = strokeColor.cgColor
        mViewBorder.lineDashPattern = [2, 2]
        mViewBorder.frame = self.bounds
        mViewBorder.fillColor = nil
        mViewBorder.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.addSublayer(mViewBorder)
    }
    
    public func autoCenterInSuperView(){
        guard let superview = superview else {return}
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    
    
//    class func favoritesNoDataView()->GIFNoDataView {
//        let gifNoDataView = GIFNoDataView(frame: .zero)
//        gifNoDataView.gifName = GIFImages.favorites.gifName
//        gifNoDataView.desrcptionAttributedValue = NSMutableAttributedString(aligment: .center).boldColored("NO_FAVROITES_TITLE".localized, color: UIColor.blue, fontSize: 16).newLine().normalColored("NO_FAVROITES_MSG".localized, color: UIColor.lightBlackColor, fontSize: 12)
//        return gifNoDataView
//    }
//

}
public extension UIStackView {
    
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
    
}
