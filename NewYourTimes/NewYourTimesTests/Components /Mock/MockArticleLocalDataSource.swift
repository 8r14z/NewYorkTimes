//
//  MockArticleLocalDataSource.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class MockArticleLocalDataSource: ArticleLocalDataSourceProtocol {
    
    private var article: Article?

    init(available: Bool) {
        if available {
            article = TestArticle
        } else {
            article = nil
        }
    }
    
    func fetchArticles(fromIndex index: Int, limit: Int, completion: (([Article]?) -> Void)?) {
        
        if let article = article {
            completion?([article])
        } else {
            completion?(nil)
        }
    }

    func saveArticles(_ articles: [Article], completion: WriteCompletionBlock?) {
        article = articles.first
        completion?(true)
    }
    
    
}
