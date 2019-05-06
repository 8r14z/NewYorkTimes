//
//  ArticleCloudDataSource.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/6/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation


protocol ArticleRemoteDataSourceProtocol {
    
    var serviceProvider: ServiceProviding { get set }
    
    func retrieveArticles(forPageIndex index: UInt, pageSize: UInt, completion: ReadCompletionBlock<Article>?)
}


class ArticleRemoteDataSource: ArticleRemoteDataSourceProtocol {
    
    
}
