//
//  SearchArticleRemoteDataSource.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



protocol SearchArticleRemoteDataSourceProtocol {
    
    var serviceProvider: ServiceProviding { get set }
    
    func fetchArticle(query: String, pageIndex: Int, completion: ReadCompletionBlock<[SearchArticle]>?)
}



class SearchArticleRemoteDataSource: SearchArticleRemoteDataSourceProtocol {
    
    var serviceProvider: ServiceProviding
    
    init(serviceProvider: ServiceProviding = URLSession(configuration: .default)) {
        self.serviceProvider = serviceProvider
    }
    
    func fetchArticle(query: String, pageIndex: Int, completion: ReadCompletionBlock<[SearchArticle]>?) {
        
        let searchAPI = API.searchArticle(searchQuery: query, pageIndex: pageIndex)
        
        serviceProvider.download(with: searchAPI.url) { (result) in
            
            switch result {
            case .success(let json):
                
                if let searchResponse = json[API.ResponseKeys.searchResponse] as? JSON,
                    let searchResult = searchResponse[API.ResponseKeys.searchResult] as? [Any] {
                    
                    do {
                        let decoder = JSONDecoder()
                        let articles = try decoder.decode([SearchArticle].self, from: searchResult)

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
