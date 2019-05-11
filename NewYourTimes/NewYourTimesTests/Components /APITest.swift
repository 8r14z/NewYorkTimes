//
//  APITest.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/10/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class APITest: XCTestCase {
    
    var testedAPI: API!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testURLForGetArticle() {
        testedAPI = .article(offset: 0, pageSize: 20)
        XCTAssert(testedAPI.url.absoluteString.hasPrefix("https://api.nytimes.com/svc/news/v3/content/all/all.json?limit=20&offset=0&api-key="), "URL is incorrect format")
    }
    
    func testURLForGetArticleWithNonZeroOffset() {
        testedAPI = .article(offset: 1, pageSize: 20)
        XCTAssert(testedAPI.url.absoluteString.hasPrefix("https://api.nytimes.com/svc/news/v3/content/all/all.json?limit=20&offset=1&api-key="), "URL is incorrect format")
    }
    
    func testURLForSearch() {
        
        testedAPI = .searchArticle(searchQuery: "xxx", pageIndex: 0)
        XCTAssert(testedAPI.url.absoluteString.hasPrefix("https://api.nytimes.com/svc/search/v2/articlesearch.json?q=xxx&page=0&api-key="), "URL is incorrect format")
    }
    
    func testURLForSearchWithEmptyQuery() {
        testedAPI = .searchArticle(searchQuery: "", pageIndex: 0)
        XCTAssert(testedAPI.url.absoluteString.hasPrefix("https://api.nytimes.com/svc/search/v2/articlesearch.json?q=&page=0&api-key="), "URL is incorrect format")
    }
}
