//
//  API.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



enum API {
    
    // All constants of NewYourTimes APIs
    //************************************************
    struct Default {
        static let pageSize: Int = 20
        static let apiKey = "FauIo832lm5wKELs5tCMUlRA9EOdZL96"
        static let scheme = "https"
        static let host = "api.nytimes.com"
    }
    
    struct ResponseKeys {
        // Article
        static let result = "results"
        static let title = "title"
        static let snippet = "abstract"
        static let publishedDate = "published_date"
        static let createdDate = "created_date"
        static let images = "multimedia"
        
        // Search
        static let searchResponse = "response"
        static let searchResult = "docs"
    }
    
    struct RequestParams {
        static let apiKey = "api-key"
        static let pageSize = "limit"
        static let offset = "offset"
        static let searchQuery = "q"
        static let pageIndex = "page"
    }
    //************************************************

    /// Articles with number of articles (pageSize) in a request and offset of first article in batch.
    case article(offset: Int, pageSize: Int)
    /// Search articles based on search term
    case searchArticle(searchQuery: String, pageIndex: Int)
    
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
            queryItems = [URLQueryItem(name: RequestParams.pageSize, value: "\(pageSize)"),
                          URLQueryItem(name: RequestParams.offset, value: "\(offset)")]
            
        case .searchArticle(let searchQuery, let pageIndex):
            queryItems = [URLQueryItem(name: RequestParams.searchQuery, value: searchQuery),
                          URLQueryItem(name: RequestParams.pageIndex, value: "\(pageIndex)")]
        }
        
        queryItems.append(URLQueryItem(name: RequestParams.apiKey, value: Default.apiKey))
        
        return queryItems
    }
}
