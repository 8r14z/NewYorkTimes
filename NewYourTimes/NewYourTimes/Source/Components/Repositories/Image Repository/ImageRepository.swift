//
//  ImageRepository.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



protocol ImageRepositoryProtocol {
    
    func image(for url: URL, completion: @escaping (UIImage?) -> Void)
}



class ImageRepository: ImageRepositoryProtocol {
    
    private let localDataSource: ImageLocalDataSourceProtocol
    private let remoteDataSource: ImageRemoteDataSourceProtocol
    
    static let shared = ImageRepository()
    
    init(local: ImageLocalDataSourceProtocol = ImageLocalDataSource(),
         remote: ImageRemoteDataSourceProtocol = ImageRemoteDataSource()) {
        
        localDataSource = local
        remoteDataSource = remote
    }
    
    /// Thread-safe
    private var cachedImages = NSCache<NSURL, UIImage>()
    
    func image(for url: URL, completion: @escaping (UIImage?) -> Void) {
        
        if let image = cachedImages.object(forKey: url as NSURL) {
            completion(image)
            
        } else {
            
            if let image = localDataSource.image(for: url) {
                cachedImages.setObject(image, forKey: url as NSURL)
                completion(image)
                
            } else {
                
                self.remoteDataSource.image(for: url, completion: { [weak self] (result) in
                    
                    if let image = try? result.get() {

                        self?.cachedImages.setObject(image, forKey: url as NSURL)
                        self?.localDataSource.saveImage(image, for: url)
                        
                        completion(image)
                        
                    } else {
                        completion(nil)
                    }
                })
            }
        }
    }
}
