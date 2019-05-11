//
//  TestArticleRepository.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestArticleRepository: XCTestCase {
    
    func testFetchStrategyCacheOnlySuccess() {
        
        let articleRepository = ArticleRepository(local: MockArticleLocalDataSource(available: true),
                                                  remote: MockArticleRemoteDataSource(response: .error))
        
        let promise = expectation(description: "")
        
        articleRepository.fetchArticles(pageOffset: 0, pageSize: 1, fetchStrategy: .cacheOnly) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertNotNil(articles)
            XCTAssertTrue(!articles!.isEmpty)
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchStrategyCacheOnlyEmpty() {
        
        let articleRepository = ArticleRepository(local: MockArticleLocalDataSource(available: false),
                                                  remote: MockArticleRemoteDataSource(response: .error))
        
        let promise = expectation(description: "")
        
        articleRepository.fetchArticles(pageOffset: 0, pageSize: 1, fetchStrategy: .cacheOnly) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertNotNil(articles)
            XCTAssertTrue(articles!.isEmpty)
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
