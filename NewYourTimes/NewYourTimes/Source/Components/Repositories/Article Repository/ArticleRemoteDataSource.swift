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

    func fetchArticles(forPageOffset offset: UInt, pageSize: UInt, completion: ReadCompletionBlock<[Article]>?)
}


class ArticleRemoteDataSource: ArticleRemoteDataSourceProtocol {
    
    var serviceProvider: ServiceProviding
    
    init(serviceProvider: ServiceProviding = URLSession(configuration: .default)) {
        self.serviceProvider = serviceProvider
    }
    
    func fetchArticles(forPageOffset offset: UInt, pageSize: UInt, completion: ReadCompletionBlock<[Article]>?) {
        
        let articleAPI = API.article(offset: offset, pageSize: pageSize)

        serviceProvider.download(with: articleAPI.url) { (result) in
            
            switch result {
            case .success(let json):
                
                if let result = json[API.JSONKeys.result] as? [Any] {
                    
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
