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
    
    // MARK: Cache Only
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
    
    
    // MARK: Server Only
    func testFetchStrategyServerOnlySuccess() {
        
        let articleRepository = ArticleRepository(local: MockArticleLocalDataSource(available: false),
                                                  remote: MockArticleRemoteDataSource(response: .hit))
        
        let promise = expectation(description: "")
        
        articleRepository.fetchArticles(pageOffset: 0, pageSize: 1, fetchStrategy: .serverOnly) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertNotNil(articles)
            XCTAssertTrue(!articles!.isEmpty)
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchStrategyServerOnlyEmpy() {
        
        let articleRepository = ArticleRepository(local: MockArticleLocalDataSource(available: false),
                                                  remote: MockArticleRemoteDataSource(response: .miss))
        
        let promise = expectation(description: "")
        
        articleRepository.fetchArticles(pageOffset: 0, pageSize: 1, fetchStrategy: .serverOnly) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertNotNil(articles)
            XCTAssertTrue(articles!.isEmpty)
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    func testFetchStrategyServerOnlyError() {
        
        let articleRepository = ArticleRepository(local: MockArticleLocalDataSource(available: false),
                                                  remote: MockArticleRemoteDataSource(response: .error))
        
        let promise = expectation(description: "")
        
        articleRepository.fetchArticles(pageOffset: 0, pageSize: 1, fetchStrategy: .serverOnly) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertNil(articles)
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: Cache First Else Server
    func testFetchStrategyCacheElseServer_CacheAvailable() {
        
        let articleRepository = ArticleRepository(local: MockArticleLocalDataSource(available: true),
                                                  remote: MockArticleRemoteDataSource(response: .error))
        
        let promise = expectation(description: "")
        
        articleRepository.fetchArticles(pageOffset: 0, pageSize: 1, fetchStrategy: .cacheFirstElseServer) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertNotNil(articles)
            XCTAssertTrue(!articles!.isEmpty)
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchStrategyCacheElseServer_CacheUnavailable() {
        
        let articleRepository = ArticleRepository(local: MockArticleLocalDataSource(available: false),
                                                  remote: MockArticleRemoteDataSource(response: .hit))
        
        let promise = expectation(description: "")
        
        articleRepository.fetchArticles(pageOffset: 0, pageSize: 1, fetchStrategy: .cacheFirstElseServer) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertNotNil(articles)
            XCTAssertTrue(!articles!.isEmpty)
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    // MARK: Cache Then Server
    func testFetchStrategyCacheThenServer_CacheAvailable() {

        let articleRepository = ArticleRepository(local: MockArticleLocalDataSource(available: true),
                                                  remote: MockArticleRemoteDataSource(response: .hit))

        let promise = expectation(description: "")

        var responseCount = 0
        articleRepository.fetchArticles(pageOffset: 0, pageSize: 1, fetchStrategy: .cacheThenServer) { (result) in

            responseCount += 1
            
            if responseCount == 1 { // Cache callback
                let articles = try? result.get()
                XCTAssertNotNil(articles)
                XCTAssertTrue(!articles!.isEmpty)
            }
            
            if responseCount == 2 { // Server callback
                let articles = try? result.get()
                XCTAssertNotNil(articles)
                XCTAssertTrue(!articles!.isEmpty)
                
                promise.fulfill()
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchStrategyCacheThenServer_CacheUnavailable() {

        let articleRepository = ArticleRepository(local: MockArticleLocalDataSource(available: false),
                                                  remote: MockArticleRemoteDataSource(response: .hit))
        
        let promise = expectation(description: "")
        
        var responseCount = 0
        articleRepository.fetchArticles(pageOffset: 0, pageSize: 1, fetchStrategy: .cacheThenServer) { (result) in
            
            responseCount += 1
            
            if responseCount == 1 { // Cache callback
                let articles = try? result.get()
                XCTAssertNotNil(articles)
                XCTAssertTrue(articles!.isEmpty) // empty
            }
            
            if responseCount == 2 { // Server callback
                let articles = try? result.get()
                XCTAssertNotNil(articles)
                XCTAssertTrue(!articles!.isEmpty)
                
                promise.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
