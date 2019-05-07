//
//  ImageCacheManager.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



protocol ImageCaching{
    
    var cachePath: String { get }
}



class ImageCacher: ImageCaching {
    
    var cachePath: String
    
    init(cachePath: String? = nil) {
        
        if let cachePath = cachePath {
            self.cachePath = cachePath
            
        } else {
            self.cachePath = Defaults.imageCachePath
        }
    }
}
