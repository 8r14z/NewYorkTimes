//
//  MockImageRemoteDataSource.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit
@testable import NewYourTimes



class MockImageRemoteDataSource: ImageRemoteDataSourceProtocol {
    
    var serviceProvider: ServiceProviding
    
    init(serviceProvider: ServiceProviding = MockServiceProvider()) {
        self.serviceProvider = serviceProvider
    }
    
    func image(for url: URL, completion: @escaping ReadCompletionBlock<UIImage?>) {
        
        let image = TestImage
        completion(.success(image))
    }
}
