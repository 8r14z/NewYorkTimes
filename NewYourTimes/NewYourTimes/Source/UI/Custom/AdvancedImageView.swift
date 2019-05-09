//
//  UIImageView+Cache.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit


protocol AdvancedImageViewProtocol {

    var imageRepository: ImageCaching { get set }
    
    func setImage(with url: URL)
}


class AdvancedImageView: UIImageView, AdvancedImageViewProtocol {
    
    var imageRepository: ImageCaching = ImageCacher()
    
    func setImage(with url: URL) {

    }
}
