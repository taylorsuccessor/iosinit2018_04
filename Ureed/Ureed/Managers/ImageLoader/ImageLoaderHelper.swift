//
//  ImageLoaderHelper.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/3/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import UIKit
import Kingfisher

enum ImageLoaderPlaceholder {
    case country
    case venueLogo
    case venueImage
    
    var image : UIImage {
        switch self {
        case .country:
            return #imageLiteral(resourceName: "flag")
        case .venueImage:
            return #imageLiteral(resourceName: "placeholder-rectagnle")
        case .venueLogo:
            return #imageLiteral(resourceName: "placeholder-square")
        }
    }
    
    
}

class ImageLoaderHelper: NSObject {
    
    class func loadImage(url:String?,into:UIImageView,pleacholder:ImageLoaderPlaceholder,shouldShowLoading : Bool = true,completion:((UIImage)->())? = nil) {
        
        guard let url = url else {
            completion?(pleacholder.image)
            return
        }
        
        into.image = pleacholder.image
        into.kf.indicatorType =  shouldShowLoading ? .activity : .none
        
        func loadImage(url:URL){
            into.kf.setImage(with: url, placeholder: pleacholder.image, options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: {
                image, error, cacheType, imageURL in
                completion?(image ?? pleacholder.image)
            })
        }
        
        let imageSize = "\(into.bounds.w)x\(into.bounds.h)"
        let fullUrl = url.contains("http") ? url : "https://ro-images-Ureed.netdna-ssl.com/crop/\(imageSize)/\(url)"
        
        if let imageUrl = URL(string: fullUrl.replacingOccurrences(of: " ", with: "%20")){
            loadImage(url: imageUrl)
        }
        else{
            into.image = pleacholder.image
            completion?(pleacholder.image)
        }
        
    }
    
    
    
    
}
