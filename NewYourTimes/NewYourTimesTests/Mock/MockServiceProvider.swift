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

        let data = articleJSON
        
        completion?(.success(data))
        
        return MockCanceller()
    }
}



class MockImageProvider: ServiceProviding {
    
    func downloadData(with url: URL, completion: ReadCompletionBlock<Data?>?) -> Cancellable {
        
        let image = TestImage
        let data = image.jpegData(compressionQuality: 1.0)
        
        completion?(.success(data))
        
        return MockCanceller()
    }
    
    func download(with url: URL, completion: ReadCompletionBlock<JSON>?) -> Cancellable {
        return MockCanceller()
    }
}
