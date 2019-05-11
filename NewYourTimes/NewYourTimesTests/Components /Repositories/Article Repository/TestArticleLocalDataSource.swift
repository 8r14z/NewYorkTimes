//
//  TestArticleLocalDataSource.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestArticleLocalDataSource: XCTestCase {
    
    
    func testWriteArticle() {
        
        let localDataSource = ArticleLocalDataSource()

        let article = Article(title: "Title",
                              snippet: "Snippet",
                              updatedDate: Date(),
                              publishedDate: Date(),
                              images: nil,
                              author: "Author",
                              publisher: "Publisher")
        
        let promise = expectation(description: "")
        
        localDataSource.saveArticles([article]) { (success) in
            
            XCTAssertTrue(success)
            
            promise.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchEmpty() {
        
        let localDataSource = ArticleLocalDataSource()
        let promise = expectation(description: "")
        
        localDataSource.fetchArticles(fromIndex: 0, limit: 1, completion: { (result) in
            
            let articles = result
            
            XCTAssertTrue(articles == nil || articles!.isEmpty)
            
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSaveAndFetch() {
        
        let localDataSource = ArticleLocalDataSource()
        
        let article = Article(title: "Title",
                              snippet: "Snippet",
                              updatedDate: Date(),
                              publishedDate: Date(),
                              images: nil,
                              author: "Author",
                              publisher: "Publisher")
        
        let promise = expectation(description: "")
        
        localDataSource.saveArticles([article]) { (success) in
            
            localDataSource.fetchArticles(fromIndex: 0, limit: 1, completion: { (result) in

                let articles = result
                
                XCTAssertTrue(articles!.count == 1)
                
                promise.fulfill()
            })
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
