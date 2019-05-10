//
//  Image+Utility.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/6/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



extension UIImage {
    
    /// Should be called in background thread
    func decoded() -> UIImage? {

        guard let cgImage = cgImage else { return nil }
        
        let height = cgImage.height
        let width = cgImage.width
        let rect = CGRect(x: 0, y: 0, width: width, height: height)

        let context = CGContext(data: nil,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: width * 4,
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.draw(cgImage, in: rect)
        
        let decodedImage = context?.makeImage()
        
        if let decodedImage = decodedImage {
            return UIImage(cgImage: decodedImage)
        }
        
        return nil
    }
}
