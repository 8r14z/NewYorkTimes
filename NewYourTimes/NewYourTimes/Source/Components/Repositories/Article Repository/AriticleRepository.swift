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
    
    func fetchArticles(pageOffset: UInt, pageSize: UInt, fetchStrategy: FetchStrategy, callBack: ReadCompletionBlock<[Article]>?)
}



class ArticleRepository: ArticleRepositoryProtocol {
    
    static let shared: ArticleRepository = {
        
        let local = ArticleLocalDataSource()
        let remote = ArticleRemoteDataSource()
        
        return ArticleRepository(local: local, remote: remote)
    }()
    
    private let localDataSource: ArticleLocalDataSourceProtocol
    private let remoteDataSource: ArticleRemoteDataSourceProtocol
    
    private var serialQueue = DispatchQueue(label: "ArticleRepositorySerialQueue")
    
    init(local: ArticleLocalDataSourceProtocol, remote: ArticleRemoteDataSourceProtocol) {
        localDataSource = local
        remoteDataSource = remote
    }

    func fetchArticles(pageOffset: UInt, pageSize: UInt, fetchStrategy: FetchStrategy, callBack: ReadCompletionBlock<[Article]>?) {

        if fetchStrategy == .serverOnly {
            remoteDataSource.fetchArticles(forPageOffset: pageOffset, pageSize: pageSize, completion: callBack)
            
        } else {
            
            // TODO: In development
            
            // Fake response
            callBack?(.success([]))
        }
    }
}



