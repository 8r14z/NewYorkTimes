//
//  AriticleRepository.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/6/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



protocol ArticleRepositoryProtocol {
    
    func fetchArticles(pageOffset: Int,
                       pageSize: Int,
                       fetchStrategy: FetchStrategy,
                       completion: ReadCompletionBlock<[Article]>?)
}



class ArticleRepository: ArticleRepositoryProtocol {
    
    static let shared = ArticleRepository()
    
    private let localDataSource: ArticleLocalDataSourceProtocol
    private let remoteDataSource: ArticleRemoteDataSourceProtocol
    
    private var isCacheFetched = false
    private var concurrentQueue = DispatchQueue(label: "ArticleRepositoryQueue", attributes: .concurrent)
    
    init(local: ArticleLocalDataSourceProtocol = ArticleLocalDataSource(),
         remote: ArticleRemoteDataSourceProtocol = ArticleRemoteDataSource()) {
        
        localDataSource = local
        remoteDataSource = remote
    }

    func fetchArticles(pageOffset: Int,
                       pageSize: Int,
                       fetchStrategy: FetchStrategy = .serverOnly,
                       completion: ReadCompletionBlock<[Article]>?) {

        concurrentQueue.async { [weak self] in
            guard let self = self else {
                return
            }
            
            if fetchStrategy == .serverOnly || self.isCacheFetched {
                self.remoteDataSource.fetchArticles(forPageOffset: pageOffset, pageSize: pageSize, completion: completion)
                
            } else {
                
                self.isCacheFetched = true
                
                self.localDataSource.fetchArticles(limit: pageSize) { [weak self] (result) in
                    guard let self = self else {
                        return
                    }
                    
                    switch result {
                    case .success(let articles):
                        
                        completion?(.success(articles))
                        
                        if (fetchStrategy == .cacheFirstElseServer && articles.isEmpty) ||
                            fetchStrategy == .cacheThenServer {
                            
                            self.remoteDataSource.fetchArticles(forPageOffset: pageOffset, pageSize: pageSize, completion: completion)
                        }
                        
                    case .failure(let error):
                        completion?(.failure(error))
                    }
                }
            }
        }
       
    }
}



