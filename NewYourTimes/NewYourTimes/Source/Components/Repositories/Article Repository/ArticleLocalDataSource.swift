//
//  ArticleLocalDataSource.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/6/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



protocol ArticleLocalDataSourceProtocol {
    
    func fetchArticles(withLimit limit: UInt, completion: ReadCompletionBlock<[Article]>?)
}



class ArticleLocalDataSource: ArticleLocalDataSourceProtocol {

    func fetchArticles(withLimit limit: UInt, completion: ReadCompletionBlock<[Article]>?) {
        completion?(.success([]))
    }
}
