//
//  MockSearchInteractor.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation
@testable import NewYourTimes



class MockSearchInteractor: SearchInteractorProtocol {
    
    var presenter: SearchPresenterProtocol?
    var repository: SearchArticleRepositoryProtocol = MockSearchRepository(response: .error)
    
    var didFetchKeywords = false
    var didSaveKeyword = false
    var didFetchArticles = false
    
    var searchKeyword: String?
    var saveKeyword: String?
    
    func fetchPreviousKeywords() {
        didFetchKeywords = true
    }
    
    func saveKeyword(_ keyword: String) {
        didSaveKeyword = true
        saveKeyword = keyword
    }
    
    func fetchSearchArticles(with keyword: String) {
        didFetchArticles = true
        searchKeyword = keyword
    }
    
    
}
