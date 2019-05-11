//
//  MockArticleInteractor.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation
@testable import NewYourTimes



class MockArticleInteractor: ArticleInteractorProtocol {
    
    var presenter: ArticlePresenterProtocol?
    var repository: ArticleRepositoryProtocol = MockArticleRepository(response: .error)
    
    var didInitialFetch = false
    var didLoadNext = false
    var didLoadPrevious = false
    
    func intialFetchArticle(at index: Int) {
        didInitialFetch = true
    }
    
    func loadNextArticle(for index: Int) {
        didLoadNext = true
    }
    
    func loadPreviousArticle(for index: Int) {
        didLoadPrevious = true
    }
}
