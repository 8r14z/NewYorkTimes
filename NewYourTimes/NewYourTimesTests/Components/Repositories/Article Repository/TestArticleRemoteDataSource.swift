//
//  TestArticleRemoteDataSource.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestArticleRemoteDataSource: XCTestCase {
    
    func testFetchArticlesSuccess() {
        
        let remoteDataSource = ArticleRemoteDataSource(serviceProvider: MockServiceProvider(response: .hit, api: .article))
        
        let promise = expectation(description: "")
        
        remoteDataSource.fetchArticles(forPageOffset: 0, pageSize: 1) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertNotNil(articles)
            XCTAssertTrue(!articles!.isEmpty)

            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchArticlesEmpty() {
        
        let remoteDataSource = ArticleRemoteDataSource(serviceProvider: MockServiceProvider(response: .miss, api: .article))
        
        let promise = expectation(description: "")
        
        remoteDataSource.fetchArticles(forPageOffset: 0, pageSize: 1) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertNotNil(articles)
            XCTAssertTrue(articles!.isEmpty)
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchArticlesError() {
        
        let remoteDataSource = ArticleRemoteDataSource(serviceProvider: MockServiceProvider(response: .error, api: .article))
        
        let promise = expectation(description: "")
        
        remoteDataSource.fetchArticles(forPageOffset: 0, pageSize: 1) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertNil(articles)
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
