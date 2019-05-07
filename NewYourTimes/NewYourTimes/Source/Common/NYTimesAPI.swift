//
//  NYTimesAPI.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



enum NYTimesAPI {
    
    // All constants of NewYourTimes APIs
    //************************************************
    struct Default {
        static let defaultPageSize = 10
        static let apiKey = "FauIo832lm5wKELs5tCMUlRA9EOdZL96"
        static let scheme = "https"
        static let host = "api.nytimes.com"
    }
    
    struct JSONKeys {
        static let result = "results"
    }
    
    struct RequestKeys {
        
        static let apiKey = "api-key"
        static let pageSize = "limit"
        static let offset = "offset"
        static let searchQuery = "q"
        static let pageIndex = "page"
    }
    //************************************************

    case article(offset: UInt, pageSize: UInt)
    case searchArticle(searchQuery: String, pageIndex: UInt)
    
    var url: URL {
        var component = URLComponents()
        component.scheme = Default.scheme
        component.host = Default.host
        component.path = path
        component.queryItems = makeQueryItems()
        return component.url! 
    }
    
    // Helpers
    private var path: String {
        switch self {
        case .article:
            return "/svc/news/v3/content/all/all.json"
            
        case .searchArticle:
            return "/svc/search/v2/articlesearch.json"
        }
    }
    
    private func makeQueryItems() -> [URLQueryItem] {
        
        var queryItems = [URLQueryItem]()
        
        switch self {
        case .article(let offset, let pageSize):
            queryItems = [URLQueryItem(name: RequestKeys.pageSize, value: "\(pageSize)"),
                          URLQueryItem(name: RequestKeys.offset, value: "\(offset)")]
            
        case .searchArticle(let searchQuery, let pageIndex):
            queryItems = [URLQueryItem(name: RequestKeys.searchQuery, value: searchQuery),
                          URLQueryItem(name: RequestKeys.pageIndex, value: "\(pageIndex)")]
        }
        
        queryItems.append(URLQueryItem(name: RequestKeys.apiKey, value: Default.apiKey))
        
        return queryItems
    }
}
