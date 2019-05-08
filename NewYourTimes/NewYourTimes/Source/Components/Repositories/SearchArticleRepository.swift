//
//  SearchArticleRepository.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



protocol SearchArticleRepositoryProtocol {
    
    func getPreviousSearchTerms() -> [String]?
    func saveSearchTerm(_ searchTerm: String)
    func fetchSearchArticles(query: String,
                             pageIndex: Int,
                             completion: ReadCompletionBlock<[SearchArticle]>?)
}



class SearchArticleRepository: SearchArticleRepositoryProtocol {
    
    private let localDataSource: SearchArticleLocalDataSourceProtocol
    private let remoteDataSource: SearchArticleRemoteDataSourceProtocol
 
    init(local: SearchArticleLocalDataSourceProtocol = SearchArticleLocalDataSource(),
         remote: SearchArticleRemoteDataSourceProtocol = SearchArticleRemoteDataSource()) {
        
        localDataSource = local
        remoteDataSource = remote
    }
    
    func getPreviousSearchTerms() -> [String]? {
        return localDataSource.fetchPreviousSearchTerms()
    }
    
    func saveSearchTerm(_ searchTerm: String) {
        localDataSource.saveSearchTerm(searchTerm)
    }
    
    func fetchSearchArticles(query: String,
                             pageIndex: Int,
                             completion: ReadCompletionBlock<[SearchArticle]>?) {
        remoteDataSource.fetchArticle(query: query, pageIndex: pageIndex, completion: completion)
    }
}
