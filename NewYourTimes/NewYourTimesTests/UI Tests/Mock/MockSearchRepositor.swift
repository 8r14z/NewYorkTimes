//
//  MockSearchRepositor.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation
@testable import NewYourTimes



class MockSearchRepository: SearchArticleRepositoryProtocol {
    
    private var response: Response
    
    var searchTerm: String?
    
    init(response: Response) {
        self.response = response
    }
    
    func getPreviousSearchTerms() -> [String]? {
        
        switch response {
        case .hit:
            return ["String1", "String2"]
        default:
            return nil
        }
    }
    
    func saveSearchTerm(_ searchTerm: String) {
        self.searchTerm = searchTerm
    }
    
    func fetchSearchArticles(query: String,
                             pageIndex: Int,
                             completion: ReadCompletionBlock<[SearchArticle]>?) {
        
        switch response {
        case .hit:
            completion?(.success([TestSearchArticle]))
        case .miss:
            completion?(.success([]))
        case .error:
            completion?(.failure(TestError))
        }
    }
}
