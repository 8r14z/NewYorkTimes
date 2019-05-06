//
//  Defines.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/4/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct Constants {
    
    static let imageCachePath = "articleImages"
    
    struct API {
        static let pageSize = 10
        static let newYourTimesKey = "FauIo832lm5wKELs5tCMUlRA9EOdZL96"
        static let scheme = "https"
        static let host = "api.nytimes.com"
    }
}



// MARK: Typealias

typealias ReadCompletionBlock<T> = ((Result<[T], Error>) -> Void)
typealias WriteCompletionBlock = ((_ successed: Bool) -> Void)



// MARK: Enum

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum FetchStrategy {
    
    /// Fecth from cache, unless data is available fetch from server
    case cacheFirstElseServer
    /// Fetch from cache, ignore server
    case cacheOnly
    /// Fetch from server, ignore cache
    case serverOnly
    /// Fetch from cache, then fecth from server.
    case cacheThenServer
}
