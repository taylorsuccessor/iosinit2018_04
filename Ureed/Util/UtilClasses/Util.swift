//
//  Util.swift
//  Util
//
//  Created by Amjad Private on 3/10/18.
//  Copyright © 2018 GameGo. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import SafariServices
import PhoneNumberKit

public class Util {
    
    public class func array(plistName:String)->[[String:Any]]{
        guard let path = Bundle.main.path(forResource: plistName, ofType: "plist") else {
            return []
        }
        
        return NSArray(contentsOfFile: path) as? [[String:Any]] ?? []
    }
    
    public class func dictionary(plistName:String)->[String:Any]{
        guard let path = Bundle.main.path(forResource: plistName, ofType: "plist") else {
            return [:]
        }
        
        return NSDictionary(contentsOfFile: path) as? [String:Any] ?? [:]
    }
    
    public class func isRTL()->Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
    
    public class func infoFor(key:String)->String?{
        return (Bundle.main.infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: "")
    }
    
    public class func showBroswer(for url:String){
        guard let url = URL(string: url) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        UIApplication.topViewController()?.presentVC(safariVC)
    }
    
    public class func countryName(countryCode:String)->String {
        let currentLocale : NSLocale = NSLocale.init(localeIdentifier :  NSLocale.current.identifier)
        return currentLocale.displayName(forKey: NSLocale.Key.countryCode, value: countryCode) ?? ""
    }
    
    public class func dialCode(for countryCode:String?)->String {
        guard let countryCode = countryCode else {return ""}
        
        guard let dialCode = PhoneNumberKit().countryCode(for: countryCode.capitalized) else {
            return ""
        }
        
        return String(dialCode)
    }
    
    public class func isValidPhoneNumber(phone:String,countryCode:String)->Bool {
        do {
            
            let _ = try PhoneNumberKit().parse(phone, withRegion: countryCode, ignoreType: false)
            return true
        }
        catch {
            return false
        }
    }
    
    private class func phoneNumber(for phone:String,countryCode:String)->PhoneNumber? {
        do {
            
            let phoneNumber = try PhoneNumberKit().parse(phone, withRegion: countryCode, ignoreType: false)
            return phoneNumber
        }
        catch {
            return nil
        }
    }
    
    public class func formatPhoneNumber(phone:String,countryCode:String)->String {
        
        //guard isValidPhoneNumber(phone: phone, countryCode: countryCode) else {return ""}
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "EN")
        guard let number  = formatter.number(from: phone)?.stringValue else {return phone}
        
        let formattedPhone = number.trimmed().trimLeadingZeroes().replacingOccurrences(of: "+", with: "")
        
        guard let phoneNumber = self.phoneNumber(for: formattedPhone, countryCode: countryCode) else {
            let dialCode = self.dialCode(for: countryCode)
            if formattedPhone.contains(dialCode){
                return "+ \(formattedPhone)"
            }else {
                return "+(\(dialCode)) \(formattedPhone)"
            }
        }
        
        return PhoneNumberKit().format(phoneNumber, toType: .international)
        
    }
    
    public class func fileContent(for url:URL)->String?{
        do {
            return try String(contentsOf: url, encoding: .utf8)
        }catch {
            return nil
        }
    }
    
    public class func url(for fileName:String)->URL?{
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        guard  let dirPath = paths.first else {return nil}
        return URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
    }

}
