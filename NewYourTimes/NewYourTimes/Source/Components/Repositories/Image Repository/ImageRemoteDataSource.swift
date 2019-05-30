//
//  ImageCloudDataSource.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



protocol ImageRemoteDataSourceProtocol {
    
    var serviceProvider: ServiceProviding { get set }
    
    func image(for url: URL, completion: @escaping ReadCompletionBlock<UIImage?>)
}



class ImageRemoteDataSource: ImageRemoteDataSourceProtocol {
    
    var serviceProvider: ServiceProviding
    
    init(serviceProvider: ServiceProviding = ServiceProvider.default) {
        self.serviceProvider = serviceProvider
    }
    
    func image(for url: URL, completion: @escaping ReadCompletionBlock<UIImage?>) {

        DispatchQueue.global().async { [weak self] in
            
            self?.serviceProvider.downloadData(with: url, completion: { (result) in
                
                switch result {
                case .success(let data):
                    if let data = data,
                        let image = UIImage(data: data) {
                        completion(.success(image))
                    } else {
                        completion(.success(nil))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }
    }
    
}
