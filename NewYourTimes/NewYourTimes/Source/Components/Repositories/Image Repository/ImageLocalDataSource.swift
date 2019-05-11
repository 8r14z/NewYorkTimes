//
//  ImageLocalDataSource.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



protocol ImageLocalDataSourceProtocol {
    
    func image(for url: URL) -> UIImage?
    func saveImage(_ image: UIImage, for url: URL)
}



class ImageLocalDataSource: ImageLocalDataSourceProtocol {
    
    private let diskAccessQueue = DispatchQueue(label: "ImageLocalDataSourceDiskAccessKey")
    let cacheDirectoryURL: URL
    
    init(cacheDirectoryName: String = Constants.imageCacheDirectory) {
        
        let fileManager = FileManager.default
        
        if let documentaryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            cacheDirectoryURL = documentaryURL.appendingPathComponent(cacheDirectoryName)
            
            if !fileManager.fileExists(atPath: cacheDirectoryURL.path) {
                try? fileManager.createDirectory(at: cacheDirectoryURL, withIntermediateDirectories: true, attributes: nil)
            }
            
        } else {
            cacheDirectoryURL = URL(fileURLWithPath: "")
        }
    }

    
    func image(for url: URL) -> UIImage? {
        
        guard FileManager.default.fileExists(atPath: cacheDirectoryURL.path) else {
            return nil
        }
        
        let md5Key = url.absoluteString.md5()
        let imageURL = cacheDirectoryURL.appendingPathComponent(md5Key)
        let imageULRString = imageURL.path

        return UIImage(contentsOfFile: imageULRString)
    }
    
    func saveImage(_ image: UIImage, for url: URL) {

        guard FileManager.default.fileExists(atPath: cacheDirectoryURL.path) else {
            return
        }
        
        diskAccessQueue.async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            let md5Key = url.absoluteString.md5()
            let imageURL = self.cacheDirectoryURL.appendingPathComponent(md5Key)
            let imageData = image.jpegData(compressionQuality: 1.0)
            try? imageData?.write(to: imageURL)
        }
    }
}
