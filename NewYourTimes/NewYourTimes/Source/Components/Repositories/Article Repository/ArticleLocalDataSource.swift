//
//  ArticleLocalDataSource.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/6/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



protocol ArticleLocalDataSourceProtocol {
    
    func fetchArticles(fromIndex index: Int, limit : Int, completion: (([Article]?) -> Void)?)
    func saveArticles(_ articles: [Article], completion: WriteCompletionBlock?)
    func removeAllArticles(completion: WriteCompletionBlock?)
}



class ArticleLocalDataSource: ArticleLocalDataSourceProtocol {
    
    private(set) var cachedArticles = [Article]()
    private var dataAccessMutex = DispatchSemaphore(value: 1)

    func fetchArticles(fromIndex index: Int, limit : Int, completion: (([Article]?) -> Void)?) {

        DispatchQueue.global().async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            self.dataAccessMutex.wait()
            defer {
                self.dataAccessMutex.signal()
            }
            
            let articleCount = self.cachedArticles.count
            if index >= 0 && index < articleCount {
                
                let upperBound = Swift.min(index + limit, articleCount)
                let fetchedArticles = Array(self.cachedArticles[index..<upperBound])
                completion?(fetchedArticles)
                
            } else {
                completion?(nil)
            }
        }
    }
    
    func saveArticles(_ articles: [Article], completion: WriteCompletionBlock?) {
        
        DispatchQueue.global().async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            self.dataAccessMutex.wait()
            defer {
                self.dataAccessMutex.signal()
            }
            
            self.cachedArticles.append(contentsOf: articles)
            completion?(true)
        }
    }
    
    func removeAllArticles(completion: WriteCompletionBlock?) {
        
        DispatchQueue.global().async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            self.dataAccessMutex.wait()
            defer {
                self.dataAccessMutex.signal()
            }
            
            self.cachedArticles.removeAll()
            completion?(true)
        }
    }
    
}
