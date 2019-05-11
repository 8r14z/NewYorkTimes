//
//  MockSearchArticleRemoteDataSource.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class MockSearchArticleRemoteDataSource: SearchArticleRemoteDataSourceProtocol {
    
    var serviceProvider: ServiceProviding
    
    private var response: Response
    
    init(response: Response) {
        self.response = response
        serviceProvider = MockServiceProvider(response: response)
    }
    
    func fetchArticle(query: String, pageIndex: Int, completion: ReadCompletionBlock<[SearchArticle]>?) {

        switch response {
        case .hit:
            completion?(.success([TestSearchArticle]))
        case .miss:
            completion?(.success([]))
        case .error:
            completion?(.failure(TestError))
        }
    }
}
