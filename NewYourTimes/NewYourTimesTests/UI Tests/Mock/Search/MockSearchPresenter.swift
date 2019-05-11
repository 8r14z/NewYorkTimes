//
//  MockSearchPresenter.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation
@testable import NewYourTimes



class MockSearchPresenter: SearchPresenterProtocol {
    
    var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?
    
    var didFetchKeywords = false
    var keywords: [String]?
    var didFetchArticlesSuccess = false
    var articles: [SearchArticle]?
    var didFetchArticlesError = false
    
    func didSelectSearchKeyword(_ keyword: String) {
        
    }
    
    func searchBarDidBeginEditing() {
        
    }
    
    func searchBarTextDidChange(_ text: String) {
        
    }
    
    func searchBarButtonDidEnter(_ text: String) {
        
    }
    
    func didFetchKeywords(_ keywords: [String]) {
        didFetchKeywords = true
        self.keywords = keywords
    }
    
    func didFetchSearchArticleSuccess(_ searchArticles: [SearchArticle]) {
        didFetchArticlesSuccess = true
        articles = searchArticles
    }
    
    func didFetchSearchArticlesError(_ error: Error) {
        didFetchArticlesError = true
    }
    
    
}
