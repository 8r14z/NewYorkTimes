//
//  HomePresenter.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



class HomePresenter: HomePresenterProtocol {
  
    weak var view: HomeViewProtocol?

    var interactor: HomeInteractorProtocol?
    
    var router: HomeRouterProtocol?
    
    private var isPullingToRefresh = false
    private var isFetchingArticles = false
    
    private(set) var articleSections = [HomeArticleSection]()

    // MARK: === VIEW EVENTS ===
    func viewDidAppear() {
        view?.showLoadingIndicator()
        initialFetchArticles()
    }
    
    func didPullToRefresh() {
        isPullingToRefresh = true
        initialFetchArticles()
    }

    func didSelectSection(_ section: Int) {
        
    }
    
    func willDisplaySection(_ section: Int) {
        let remainItems = articleSections.count - section
        if remainItems < 3 {
            fetchMoreArticles()
        }
    }

    // MARK: === INTERACTOR EVENTS ===
    func didInitialFetchSuccess(_ articles: [Article]) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            if self.isPullingToRefresh {
                self.isPullingToRefresh = false
                self.view?.hidePullToRefreshIndicator()
            } else {
                self.view?.hideLoadingIndicator()
            }
            
            let sections = articles.map {
                HomeArticleSection(title: $0.title, snippet: $0.snippet, publishedDate: $0.publishedDate, image: $0.banner())
            }
            
            self.isFetchingArticles = false
            self.view?.reloadView(with: sections)
        }
    }
    
    func didFetchSuccess(_ articles: [Article]) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            let sections = articles.map {
                HomeArticleSection(title: $0.title, snippet: $0.snippet, publishedDate: $0.publishedDate, image: $0.banner())
            }
            
            self.isFetchingArticles = false
            self.view?.updateView(with: sections)
        }
    }

    func didFetchError(_ error: Error) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.view?.showError(error)
        }
    }
    
    private func initialFetchArticles() {
        guard !isFetchingArticles else {
            return
        }
        
        isFetchingArticles = true
        
        interactor?.initialFetchArticles()
    }
    
    private func fetchMoreArticles() {
        guard !isFetchingArticles else {
            return
        }
        
        isFetchingArticles = true
        
        interactor?.fetchArticles()
    }
}
