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
    
    var selectedSection = -1
    var displaySection = -1
    
    var didExecuteViewDidAppear = false
    var didPullToRefreshData = false
    var didSelectSection = false
    var willDisplaySection = false
    var didSelectSearchItem = false
    
    var didIntialFetchSuccess = false
    var didInitialFetchError = false
    var didFetchSuccess = false
    var didFetchError = false
    
    var articles: [Article]?
    
    func viewDidAppear() {
        didExecuteViewDidAppear = true
        interactor?.initialFetchArticles()
    }
    
    func didPullToRefresh() {
        didPullToRefreshData = true
        interactor?.initialFetchArticles()
    }
    
    func didSelectSection(_ section: HomeArticleSection, sectionIndex: Int) {
        didSelectSection = true
        selectedSection = sectionIndex
    }
    
    func willDisplaySection(_ section: HomeArticleSection, sectionIndex: Int, sectionCount: Int) {
        willDisplaySection = true
        displaySection = sectionIndex

    }
    
    func didSelectSearch() {
        didSelectSearchItem = true
    }
    
    ///
    func didInitialFetchSuccess(_ articles: [Article]) {
        self.articles = articles
        didIntialFetchSuccess = true
    }
    
    func didIntialFetchError(_ error: Error) {
        self.articles = nil
        didInitialFetchError = true
    }
    
    func didFetchSuccess(_ articles: [Article]) {
        self.articles = articles
        didFetchSuccess = true
    }
    
    func didFetchError(_ error: Error) {
        self.articles = nil
        didFetchError = true
    }
    
}
