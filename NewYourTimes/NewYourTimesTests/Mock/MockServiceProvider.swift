//
//  MockServiceProvider.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class MockCanceller: Cancellable {
    
    func cancel() {  }
}



class MockServiceProvider: ServiceProviding {
    
    func downloadData(with url: URL, completion: ReadCompletionBlock<Data?>?) -> Cancellable {
        
        let data = Data(count: 1024)
        
        completion?(.success(data))
        
        return MockCanceller()
    }
    
    func download(with url: URL, completion: ReadCompletionBlock<JSON>?) -> Cancellable {

        let data = ArticleJSON
        
        completion?(.success(data))
        
        return MockCanceller()
    }
}



class MockImageProvider: ServiceProviding {
    
    private var response: Response
    
    init(response: Response) {
        self.response = response
    }
    
    func downloadData(with url: URL, completion: ReadCompletionBlock<Data?>?) -> Cancellable {
        
        switch response {
        case .hit:
            let image = TestImage
            let data = image.jpegData(compressionQuality: 1.0)
            completion?(.success(data))
            
        case .miss:
            completion?(.success(nil))
         
        case .error:
            completion?(.failure(TestError))
        }

        return MockCanceller()
    }
    
    func download(with url: URL, completion: ReadCompletionBlock<JSON>?) -> Cancellable {
        return MockCanceller()
    }
}
