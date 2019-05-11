//
//  TestSearchArticleLocalDataSource.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestSearchArticleLocalDataSource: XCTestCase {
    
    override func tearDown() {
        UserDefaults.standard.removeAllData(forKey: Constants.searchArticleDBKey)
    }
    
    func testFetchDataSuccess() {
        
        let localDataSource = SearchArticleLocalDataSource(store: MockDatabaseStore(available: true))
        let searchTerms = localDataSource.fetchPreviousSearchTerms()
        
        XCTAssertTrue(searchTerms != nil && !searchTerms!.isEmpty)
    }
    
    func testFetchDataEmpty() {
        
        let localDataSource = SearchArticleLocalDataSource(store: MockDatabaseStore(available: false))
        let searchTerms = localDataSource.fetchPreviousSearchTerms()
        
        XCTAssertTrue(searchTerms == nil || searchTerms!.isEmpty)
    }
    
    func testSaveAndFetchData() {
        
        let localDataSource = SearchArticleLocalDataSource(store: MockDatabaseStore(available: false))
        
        var searchTerms = localDataSource.fetchPreviousSearchTerms()
        XCTAssertTrue(searchTerms == nil || searchTerms!.isEmpty)
        
        let keyword = "This is search keywork"
        localDataSource.saveSearchTerm(keyword)
        
        searchTerms = localDataSource.fetchPreviousSearchTerms()
        XCTAssertTrue(searchTerms != nil && !searchTerms!.isEmpty)
    }
    
    func testSaveEmptySearchTerm() {
        
        let localDataSource = SearchArticleLocalDataSource(store: MockDatabaseStore(available: true))
        
        var searchTerms = localDataSource.fetchPreviousSearchTerms()
        XCTAssertTrue(searchTerms != nil || !searchTerms!.isEmpty)
        
        let count = searchTerms!.count

        let emptyKeyword = ""
        localDataSource.saveSearchTerm(emptyKeyword)
        
        searchTerms = localDataSource.fetchPreviousSearchTerms()
        XCTAssertTrue(searchTerms != nil && !searchTerms!.isEmpty)
        
        XCTAssert(searchTerms!.count == count)
    }
    
    func testSaveSameSearchTerm() {
        
        let localDataSource = SearchArticleLocalDataSource(store: MockDatabaseStore(available: false))
        
        var searchTerms = localDataSource.fetchPreviousSearchTerms()
        XCTAssertTrue(searchTerms == nil || searchTerms!.isEmpty)
        
        let keyword = "This is search keywork"
        localDataSource.saveSearchTerm(keyword)
        
        searchTerms = localDataSource.fetchPreviousSearchTerms()
        XCTAssertTrue(searchTerms != nil && !searchTerms!.isEmpty)
        
        let count = searchTerms!.count
        
        localDataSource.saveSearchTerm(keyword)
        
        searchTerms = localDataSource.fetchPreviousSearchTerms()
        XCTAssertTrue(searchTerms != nil && !searchTerms!.isEmpty)
        
        XCTAssert(searchTerms!.count == count)
    }
}
