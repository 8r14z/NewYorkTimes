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

    func retrieveArticles(forPageOffset offset: UInt, pageSize: UInt, completion: ReadCompletionBlock<[Article]>?)
}


class ArticleRemoteDataSource: ArticleRemoteDataSourceProtocol {
    
    var serviceProvider: ServiceProviding
    
    init(serviceProvider: ServiceProviding = URLSession(configuration: .default)) {
        self.serviceProvider = serviceProvider
    }
    
    func retrieveArticles(forPageOffset offset: UInt, pageSize: UInt, completion: ReadCompletionBlock<[Article]>?) {
        
        let articleAPI: NYTimesAPI = .article(offset: offset, pageSize: pageSize)
        let request = URLRequest(url: articleAPI.url)
        
        serviceProvider.download(with: request) { (result) in
            
            switch result {
            case .success(let json):
                
                if let result = json[NYTimesAPI.JSONKeys.result] {
                    
                    do {
                        
                        let data = try JSONSerialization.data(withJSONObject: result)
                        let articles = try JSONDecoder().decode([Article].self, from: data)
                        
                        completion?(.success(articles.filter { $0.images != nil }))
                        
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
