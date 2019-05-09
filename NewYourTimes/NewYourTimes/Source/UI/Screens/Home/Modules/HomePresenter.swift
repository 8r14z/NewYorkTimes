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

    // MARK: === VIEW EVENTS ===
    func viewDidAppear() {
        
        if !isFetchingArticles  {
            isFetchingArticles = true
            
            view?.showLoadingIndicator()
            interactor?.initialFetchArticles()
        }
    }
    
    func didPullToRefresh() {
        
        if !isFetchingArticles {
            isFetchingArticles = true
            isPullingToRefresh = true

            interactor?.initialFetchArticles()
        }
    }
    
    func didSelectSection(_ section: HomeArticleSection) {
        if let view = view {
            router?.navigateToArticleView(from: view)
        }
    }
    
    func willDisplaySection(_ section: HomeArticleSection, sectionIndex: Int, sectionCount: Int) {
        
        if !isFetchingArticles {
            
            let remainItems = sectionCount - sectionIndex
            if remainItems < 4 {
                isFetchingArticles = true
                interactor?.fetchArticles()
            }
        }
    }
    
    func didSelectSearch() {
        router?.navigateToSearchArticleView(from: view!)
    }

    // MARK: === INTERACTOR EVENTS ===
    func didInitialFetchSuccess(_ articles: [Article]) {
        DispatchQueue.main.async { [weak self] in
            self?.didInitialFetch(.success(articles))
        }
    }
    
    func didIntialFetchError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.didInitialFetch(.failure(error))
        }
    }
    
    func didFetchSuccess(_ articles: [Article]) {
        DispatchQueue.main.async { [weak self] in
            self?.didFetch(.success(articles))
        }
    }

    func didFetchError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.didFetch(.failure(error))
        }
    }
    
    
    // MARK: === PRIVATE ===
    private func didInitialFetch(_ result: Result<[Article], Error>) {
        
        if self.isPullingToRefresh {
            self.isPullingToRefresh = false
            self.view?.hidePullToRefreshIndicator()
        } else {
            self.view?.hideLoadingIndicator()
        }
        
        self.isFetchingArticles = false
        
        switch result {
        case .success(let articles):
            view?.reloadView(with: parse(articles))
            
        case .failure(let error):
            view?.showError(error)
        }
    }
    
    private func didFetch(_ result: Result<[Article], Error>) {
        
        self.isFetchingArticles = false
        
        switch result {
        case .success(let articles):
            view?.updateView(with: parse(articles))
            
        case .failure(let error):
            view?.showError(error)
        }
    }
    
    private func parse(_ articles: [Article]) -> [HomeArticleSection] {
        return articles.map {
            HomeArticleSection(title: $0.title, snippet: $0.snippet, publishedDate: $0.publishedDate, image: $0.banner())
        }
    }
}
