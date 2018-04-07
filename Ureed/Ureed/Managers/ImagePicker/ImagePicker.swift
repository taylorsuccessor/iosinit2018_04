//
//  ImagePicker.swift
//  Ureed
//
//  Created by Amjad Private on 2/25/18.
//  Copyright © 2018 Ureed. All rights reserved.
//

import UIKit
import Fusuma

class ImagePicker: NSObject {

    var completion:((UIImage?)->())?
    
//    var fusuma : FusumaViewController {
//        return
//    }
    
    func showImagePicker(from source:UIViewController){
        let fusuma = FusumaViewController()
        fusuma.delegate = self
       // fusuma.hasVideo = false //To allow for video capturing with .library and .camera available by default
        fusuma.allowMultipleSelection = false // You can select multiple photos from the camera roll. The default value is false.
        
        source.present(fusuma, animated: true, completion: nil)
    }
}
extension ImagePicker : FusumaDelegate {
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        self.completion?(image)
//        s.dismissVC(completion: {
//
//        })
        
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        self.completion?(images.first)

    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        
    }
    
    func fusumaCameraRollUnauthorized() {
        self.completion?(nil)

    }
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode, metaData: ImageMetadata){
        
    }
    
    func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode){
        self.completion?(image)
    }
    
    func fusumaClosed(){
        
    }
    func fusumaWillClosed(){
        
    }

    
    
}
