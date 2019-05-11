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
    
    private var response: Response
    
    init(response: Response) {
        self.response = response
        serviceProvider = MockServiceProvider(response: response)
    }
    
    func image(for url: URL, completion: @escaping ReadCompletionBlock<UIImage?>) {
        
        switch response {
        case .hit:
            let image = TestImage
            completion(.success(image))
            
        case .miss:
            completion(.success(nil))
            
        case .error:
            completion(.failure(TestError))
        }
    }
}
