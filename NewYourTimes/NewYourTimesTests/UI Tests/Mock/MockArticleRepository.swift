//
//  MockArticleRepository.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation
@testable import NewYourTimes



class MockArticleRepository: ArticleRepositoryProtocol {
    
    private var response: Response
    
    init(response: Response) {
        self.response = response
    }
    
    func fetchArticles(pageOffset: Int,
                       pageSize: Int,
                       fetchStrategy: FetchStrategy,
                       completion: ReadCompletionBlock<[Article]>?) {
        
        switch response {
        case .hit:
            completion?(.success([TestArticle]))
        case .miss:
            completion?(.success([]))
        case .error:
            completion?(.failure(TestError))
        }
    }
}



