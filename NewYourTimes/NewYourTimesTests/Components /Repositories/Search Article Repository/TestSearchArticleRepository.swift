//
//  TestSearchArticleRepository.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestSearchArticleRepository: XCTestCase {
    
    override func tearDown() {
        UserDefaults.standard.removeAllData(forKey: Constants.searchArticleDBKey)
    }
    
    func testGetPrivousSearchTermSuccess() {
        
        let searchArticleRepository = SearchArticleRepository(local: MockSearchArticleLocalDataSource(available: true),
                                                              remote: MockSearchArticleRemoteDataSource(response: .error))
        
        let previousSearchTerm = searchArticleRepository.getPreviousSearchTerms()
        
        XCTAssertNotNil(previousSearchTerm)
        XCTAssertTrue(!previousSearchTerm!.isEmpty)
    }
    
    func testGetPrivousSearchTermEmpty() {
        
        let searchArticleRepository = SearchArticleRepository(local: MockSearchArticleLocalDataSource(available: false),
                                                              remote: MockSearchArticleRemoteDataSource(response: .error))
        
        let previousSearchTerm = searchArticleRepository.getPreviousSearchTerms()
        
        XCTAssertTrue(previousSearchTerm == nil || previousSearchTerm!.isEmpty)
    }
    
    func testSaveAndFetchSearchTerm() {
        
        let searchArticleRepository = SearchArticleRepository(local: MockSearchArticleLocalDataSource(available: false),
                                                              remote: MockSearchArticleRemoteDataSource(response: .error))
        
        var previousSearchTerm = searchArticleRepository.getPreviousSearchTerms()
        XCTAssertTrue(previousSearchTerm == nil || previousSearchTerm!.isEmpty)
        
        let keyword = "This is search keywork"
        searchArticleRepository.saveSearchTerm(keyword)
        
        previousSearchTerm = searchArticleRepository.getPreviousSearchTerms()
        XCTAssertTrue(previousSearchTerm != nil && !previousSearchTerm!.isEmpty)
    }
    
    func testSaveEmptyKeyword() {
        
        let searchArticleRepository = SearchArticleRepository(local: MockSearchArticleLocalDataSource(available: true),
                                                              remote: MockSearchArticleRemoteDataSource(response: .error))
        
        var previousSearchTerm = searchArticleRepository.getPreviousSearchTerms()
        XCTAssertTrue(previousSearchTerm != nil || !previousSearchTerm!.isEmpty)
        
        let count = previousSearchTerm!.count
        
        let keyword = ""
        searchArticleRepository.saveSearchTerm(keyword)
        
        previousSearchTerm = searchArticleRepository.getPreviousSearchTerms()
        XCTAssertTrue(previousSearchTerm != nil && !previousSearchTerm!.isEmpty)
        
        XCTAssert(count == previousSearchTerm!.count)
    }
    
    func testFetchSearchArticlesSuccess() {
        
        let searchArticleRepository = SearchArticleRepository(local: MockSearchArticleLocalDataSource(available: false),
                                                              remote: MockSearchArticleRemoteDataSource(response: .hit))
        
        let promise = expectation(description: "")
        
        searchArticleRepository.fetchSearchArticles(query: "query", pageIndex: 0) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertNotNil(articles)
            XCTAssertTrue(!articles!.isEmpty)
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchSearchArticlesEmpty() {
        
        let searchArticleRepository = SearchArticleRepository(local: MockSearchArticleLocalDataSource(available: false),
                                                              remote: MockSearchArticleRemoteDataSource(response: .miss))
        
        let promise = expectation(description: "")
        
        searchArticleRepository.fetchSearchArticles(query: "query", pageIndex: 0) { (result) in
            
            let articles = try? result.get()
            
            XCTAssertTrue(articles == nil || articles!.isEmpty)
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchSearchArticlesError() {
        
        let searchArticleRepository = SearchArticleRepository(local: MockSearchArticleLocalDataSource(available: false),
                                                              remote: MockSearchArticleRemoteDataSource(response: .error))
        
        let promise = expectation(description: "")
        
        searchArticleRepository.fetchSearchArticles(query: "query", pageIndex: 0) { (result) in
            
            var articles: [SearchArticle]?
            var error: Error?
            
            switch result {
            case .success(let arts):
                articles = arts
            case .failure(let err):
                error = err
            }
            
            XCTAssertNil(articles)
            XCTAssertNotNil(error)
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
