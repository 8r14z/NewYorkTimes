//
//  MockHomePresenter.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation
@testable import NewYourTimes



class MockHomePresenter: HomePresenterProtocol {
    
    var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    
    var didIntialFetchSuccess: Bool = false
    var didInitialFetchError: Bool = false
    var didFetchSuccess: Bool = false
    var didFetchError: Bool = false
    
    func viewDidAppear() {
        interactor?.initialFetchArticles()
    }
    
    func didPullToRefresh() {
        interactor?.initialFetchArticles()
    }
    
    func didSelectSection(_ section: HomeArticleSection, sectionIndex: Int) {
        
    }
    
    func willDisplaySection(_ section: HomeArticleSection, sectionIndex: Int, sectionCount: Int) {
        
    }
    
    func didSelectSearch() {
        
    }
    
    ///
    func didInitialFetchSuccess(_ articles: [Article]) {
        didIntialFetchSuccess = true
    }
    
    func didIntialFetchError(_ error: Error) {
        didInitialFetchError = true
    }
    
    func didFetchSuccess(_ articles: [Article]) {
        didFetchSuccess = true
    }
    
    func didFetchError(_ error: Error) {
        didFetchError = true
    }
    
}
