//
//  TestSearchArticleRemoteDataSource.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestSearchArticleRemoteDataSource: XCTestCase {
    
    func testFetchSearchArticleSuccess() {
        
        let remoteDataSource = SearchArticleRemoteDataSource(serviceProvider: MockServiceProvider(response: .hit, api: .search))
        
        let promise = expectation(description: "")
        
        remoteDataSource.fetchArticle(query: "query", pageIndex: 1) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertNotNil(articles)
            XCTAssertTrue(!articles!.isEmpty)
            
            promise.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchSearchArticleEmpty() {
        
        let remoteDataSource = SearchArticleRemoteDataSource(serviceProvider: MockServiceProvider(response: .miss, api: .search))
        
        let promise = expectation(description: "")
        
        remoteDataSource.fetchArticle(query: "query", pageIndex: 1) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertTrue(articles == nil || articles!.isEmpty)
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchSearchArticleError() {
        
        let remoteDataSource = SearchArticleRemoteDataSource(serviceProvider: MockServiceProvider(response: .error, api: .search))
        
        let promise = expectation(description: "")
        
        remoteDataSource.fetchArticle(query: "query", pageIndex: 1) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertNil(articles)
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
