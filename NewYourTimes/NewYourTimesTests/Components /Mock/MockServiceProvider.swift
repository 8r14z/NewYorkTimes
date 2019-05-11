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
    
    private var response: Response
    private var api: TestAPI?
    init(response: Response, api: TestAPI? = nil) {
        self.response = response
        self.api = api
    }
    
    func downloadData(with url: URL, completion: ReadCompletionBlock<Data?>?) -> Cancellable {
        
        guard api == nil else {
            fatalError()
        }
        
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

        guard let api = api else {
            fatalError()
        }
        
        let jsonObject: JSON
        
        switch api {
        case .article:
            jsonObject = ArticleResponse
        case .search:
            jsonObject = SearchArticleResponse
        }
        
        switch response {
        case .hit:
            completion?(.success(jsonObject))
            
        case .miss:
            completion?(.success([:]))
            
        case .error:
            completion?(.failure(TestError))
        }

        return MockCanceller()
    }
}
