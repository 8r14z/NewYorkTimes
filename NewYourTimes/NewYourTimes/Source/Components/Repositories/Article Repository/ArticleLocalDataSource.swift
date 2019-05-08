//
//  ArticleLocalDataSource.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/6/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



protocol ArticleLocalDataSourceProtocol {
    
    func fetchArticles(limit: Int, completion: ReadCompletionBlock<[Article]>?)
    func saveArticles(_ articles: [Article], completion: WriteCompletionBlock?)
}



class ArticleLocalDataSource: ArticleLocalDataSourceProtocol {
    
   
    func fetchArticles(limit: Int, completion: ReadCompletionBlock<[Article]>?) {
        completion?(.success([]))
    }
    
    func saveArticles(_ articles: [Article], completion: WriteCompletionBlock?) {
        completion?(true)
    }
    
}
