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
    var repository: ArticleRepositoryProtocol = MockArticleRepository(response: .error)
    
    var didIntialFetch = false
    var didFetch = false
    
    func initialFetchArticles() {
        didIntialFetch = true
    }
    
    func fetchArticles() {
        didFetch = true
    }

}
