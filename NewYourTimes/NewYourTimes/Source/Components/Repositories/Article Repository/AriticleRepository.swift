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
    
    init(local: ArticleLocalDataSourceProtocol = ArticleLocalDataSource(),
         remote: ArticleRemoteDataSourceProtocol = ArticleRemoteDataSource()) {
        
        localDataSource = local
        remoteDataSource = remote
    }

    func fetchArticles(pageOffset: Int,
                       pageSize: Int,
                       fetchStrategy: FetchStrategy,
                       completion: ReadCompletionBlock<[Article]>?) {

        DispatchQueue.global().async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            if fetchStrategy == .serverOnly {
                self._fetchArticlesFromRemote(pageOffset: pageOffset, pageSize: pageSize, completion: completion)
                
            } else {
     
                self.localDataSource.fetchArticles(fromIndex: pageOffset, limit: pageSize) { [weak self] (result) in
                    
                    guard let self = self else {
                        return
                    }
                    
                    switch result {
                    case .success(let articles):
                        
                        if fetchStrategy == .cacheOnly ||
                            (fetchStrategy == .cacheFirstElseServer && !articles.isEmpty) {
                            completion?(.success(articles))
                            return
                        }
                        
                        if fetchStrategy == .cacheThenServer {
                            completion?(.success(articles))
                        }

                        self._fetchArticlesFromRemote(pageOffset: pageOffset, pageSize: pageSize, completion: completion)
                        
                    case .failure(let error):
                        completion?(.failure(error))
                    }
                }
            }
        }
    }
    
    private func _fetchArticlesFromRemote(pageOffset: Int,
                                  pageSize: Int,
                                  completion: ReadCompletionBlock<[Article]>?) {
        
        remoteDataSource.fetchArticles(forPageOffset: pageOffset, pageSize: pageSize, completion: { [weak self] (result) in
            
            if let articles = try? result.get() {
                self?.localDataSource.saveArticles(articles, completion: nil)
            }
            
            completion?(result)
        })
    }
}



