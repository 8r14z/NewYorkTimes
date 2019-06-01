//
//  MockArticleRemoteDataSource.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//


import UIKit
@testable import NewYourTimes



class MockArticleRemoteDataSource: ArticleRemoteDataSourceProtocol {
    
    var serviceProvider: ServiceProviding
    
    private var response: Response
    
    init(response: Response) {
        self.response = response
        serviceProvider = MockServiceProvider(response: response)
    }
    
    func fetchArticles(forPageOffset offset: Int, pageSize: Int, completion: ReadCompletionBlock<[Article]>?) -> Cancellable {
        
        switch response {
        case .hit:
            completion?(.success([TestArticle]))
        case .miss:
            completion?(.success([]))
        case .error:
            completion?(.failure(TestError))
        }
        
        return MockCanceller()
    }
}
