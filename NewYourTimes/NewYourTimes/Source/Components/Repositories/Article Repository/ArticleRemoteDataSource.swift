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

    @discardableResult
    func fetchArticles(forPageOffset offset: Int, pageSize: Int, completion: ReadCompletionBlock<[Article]>?) -> Cancellable
}


class ArticleRemoteDataSource: ArticleRemoteDataSourceProtocol {
    
    var serviceProvider: ServiceProviding
    
    init(serviceProvider: ServiceProviding = ServiceProvider.default) {
        self.serviceProvider = serviceProvider
    }
    
    @discardableResult
    func fetchArticles(forPageOffset offset: Int, pageSize: Int, completion: ReadCompletionBlock<[Article]>?) -> Cancellable {
        
        let articleAPI = API.article(offset: offset, pageSize: pageSize)
        
        return serviceProvider.download(with: articleAPI.url) { (result) in
            
            switch result {
            case .success(let json):
                
                if let result = json[API.ResponseKeys.result] as? [Any] {
                    
                    do {
                        let decoder = JSONDecoder(dateDecodingFormat: .iso8601DateAndTime)
                        let articles = try decoder.decode([Article].self, from: result)
                        
                        completion?(.success(articles))
                        
                    } catch {
                        completion?(.failure(error))
                    }
                    
                } else {
                    completion?(.success([]))
                }
                
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }

}
