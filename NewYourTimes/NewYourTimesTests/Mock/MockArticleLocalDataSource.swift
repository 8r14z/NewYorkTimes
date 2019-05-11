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
    
    private var response: Response
    init(reponse: Response) {
        self.response = response
    }
    
    func fetchArticles(fromIndex index: Int, limit: Int, completion: ReadCompletionBlock<[Article]>?) {
        
    }
    
    func fetchArticles(limit: Int, completion: ReadCompletionBlock<[Article]>?) {
        
    }
    
    func saveArticles(_ articles: [Article], completion: WriteCompletionBlock?) {
        
    }
    
    
}
