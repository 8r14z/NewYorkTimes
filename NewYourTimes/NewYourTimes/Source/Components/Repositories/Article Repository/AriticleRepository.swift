//
//  AriticleRepository.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/6/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



protocol ArticleRepositoryProtocol {
    
    @discardableResult
    func fetchArticles(pageOffset: Int,
                       pageSize: Int,
                       fetchStrategy: FetchStrategy,
                       completion: ReadCompletionBlock<[Article]>?) -> Cancellable
}



class ArticleRepository: ArticleRepositoryProtocol {
    
    static let shared = ArticleRepository()
    
    let localDataSource: ArticleLocalDataSourceProtocol
    let remoteDataSource: ArticleRemoteDataSourceProtocol
    
    private let operationQueue: OperationQueue

    init(local: ArticleLocalDataSourceProtocol = ArticleLocalDataSource(),
         remote: ArticleRemoteDataSourceProtocol = ArticleRemoteDataSource()) {
        
        localDataSource = local
        remoteDataSource = remote
        
        operationQueue = OperationQueue()
    }

    @discardableResult
    func fetchArticles(pageOffset: Int,
                       pageSize: Int,
                       fetchStrategy: FetchStrategy,
                       completion: ReadCompletionBlock<[Article]>?) -> Cancellable {
        
        let operation = ArticleQueryOperation(repository: self,
                                              fetchStrategy: fetchStrategy,
                                              pageOffset: pageOffset,
                                              pageSize: pageSize,
                                              resultHandler: completion)
        operationQueue.addOperation(operation)

        return operation
    }
    
    
}



private final class ArticleQueryOperation: Operation, Cancellable {
    
    private var networkTask: Cancellable?
    let fetchStrategy: FetchStrategy
    let pageOffset: Int
    let pageSize: Int
    let repository: ArticleRepository
    let resultHandler: ReadCompletionBlock<[Article]>?
    
    private var _isFinished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isFinished: Bool {
        return _isFinished
    }

    init(repository: ArticleRepository,
         fetchStrategy: FetchStrategy,
         pageOffset: Int,
         pageSize: Int,
         resultHandler: ReadCompletionBlock<[Article]>?) {
        
        self.repository = repository
        self.fetchStrategy = fetchStrategy
        self.pageOffset = pageOffset
        self.pageSize = pageSize
        self.resultHandler = resultHandler
    }
    
    deinit {
        print("Deinit")
    }
    
    override func start() {

        if isCancelled {
            _isFinished = true
            return
        }
        
        if fetchStrategy == .serverOnly {
            fetchArticlesFromRemote()
            
        } else {
            
            repository.localDataSource.fetchArticles(fromIndex: pageOffset, limit: pageSize) { [weak self] (result) in
                
                guard let self = self else {
                    return
                }
                
                let articles = result ?? []
                
                if self.fetchStrategy == .cacheOnly ||
                    (self.fetchStrategy == .cacheFirstElseServer && !articles.isEmpty) {
                    self.resultHandler?(.success(articles))
                    return
                }
                
                if self.fetchStrategy == .cacheThenServer {
                    self.resultHandler?(.success(articles))
                }
                
                self.fetchArticlesFromRemote()
            }
        }
    }
    
    private func fetchArticlesFromRemote() {
        
        networkTask = repository.remoteDataSource.fetchArticles(forPageOffset: pageOffset, pageSize: pageSize, completion: { [weak self] (result) in
            
            if let articles = try? result.get() {
                self?.repository.localDataSource.saveArticles(articles, completion: nil)
            }
            
            self?.resultHandler?(result)
            self?._isFinished = true
        })
    }

    override func cancel() {
        super.cancel()
        networkTask?.cancel()
    }
}

