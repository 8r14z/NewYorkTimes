//
//  UIImageView+Cache.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit


protocol ImageViewCaching {
    
    var imageCacheManager: ImageCacheManaging { get set }
    
    func setImage(withURL url: URL)
}


class AdvancedImageView: UIImageView, ImageViewCaching {
    
    var imageCacheManager: ImageCacheManaging = ImageCacheManager()
    
    func setImage(withURL url: URL) {
        
    }
}
