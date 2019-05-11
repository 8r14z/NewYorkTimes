//
//  MockHomeInteractor.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation
@testable import NewYourTimes



class MockHomeInteractor: HomeInteractorProtocol {
    
    var presenter: HomePresenterProtocol?
    var repository: ArticleRepositoryProtocol
    
    var didIntialFetch = false
    var didFetch = false
    
    private var response: Response
    init(response: Response = .hit) {
        self.response = response
        repository = MockArticleRepository(response: response)
    }
    
    func initialFetchArticles() {
        
        didIntialFetch = true
        
        switch response {
        case .hit, .miss:
            presenter?.didInitialFetchSuccess([TestArticle])
        case .error:
            presenter?.didIntialFetchError(TestError)
        }
    }
    
    func fetchArticles() {
        
        didFetch = true
        
        switch response {
        case .hit, .miss:
            presenter?.didFetchSuccess([TestArticle])
        case .error:
            presenter?.didFetchError(TestError)
        }
    }

}
