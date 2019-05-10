//
//  UIImageView+Cache.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit


protocol AdvancedImageViewProtocol {

    var imageRepository: ImageRepositoryProtocol { get set }
    
    func setImage(with url: URL)
}


class AdvancedImageView: UIImageView, AdvancedImageViewProtocol {
    
    lazy var imageRepository: ImageRepositoryProtocol = ImageRepository.shared
    
    private let mutex = DispatchSemaphore(value: 1)
    private var currentURL: URL?
    
    func setImage(with url: URL) {
        
        image = nil
        backgroundColor = .lightGray
        
        DispatchQueue.global().async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            self.mutex.wait()
            self.currentURL = url
            self.mutex.signal()
            
            self.imageRepository.image(for: url, completion: { [weak self] (image) in
                
                guard let self = self else {
                    return
                }
                
                self.mutex.wait()
                let currentURL = self.currentURL
                self.mutex.signal()
                
                if let image = image,
                    currentURL == url {
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.image = image
                    }
                }
            })
        }
    }
}
