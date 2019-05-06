//
//  AriticleRepository.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/6/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



public extension Notification.Name {
    static let newArticleUpdated = Notification.Name("newArticleUpdated")
}



protocol ArticleRepositoryProtocol: BaseDataRepositoryProtocol {
    
    func getArticles(onCacheCompletion: ReadCompletionBlock<Article>?,
                     onCompletion: ReadCompletionBlock<Article>?)
}



class ArticleRepository: ArticleRepositoryProtocol {
    
    private let localDataSource: ArticleLocalDataSourceProtocol
    private let remoteDataSource: ArticleRemoteDataSourceProtocol
    
    init(local: ArticleLocalDataSourceProtocol,
         remote: ArticleRemoteDataSourceProtocol) {
        localDataSource = local
        remoteDataSource = remote
    }
    
    func getArticles(onCacheCompletion: ReadCompletionBlock<Article>?, onCompletion: ReadCompletionBlock<Article>?) {
        
        DispatchQueue.global().async { [weak self] in
            
            guard let self = self else {
                return
            }
        }
    }

}



