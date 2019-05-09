//
//  SearchPresenter.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



class SearchPresenter: SearchPresenterProtocol {

    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?
    
    private var isFetchingArticles = false
    private var timer: Timer?
    
    // MARK: === VIEW EVENTS ===
    func searchBarDidBeginEditing() {
        interactor?.fetchPreviousKeywords()
    }
    
    func didSelectSearchKeyword(_ keyword: String) {
        view?.setSearchBarTextPlaceholder(keyword)
        view?.removeFocusOnSearchBar()
        view?.showLoadingIndicator()
        interactor?.fetchSearchArticles(with: keyword)
    }
    
    func searchTextDidChange(_ text: String) {
        
        timer?.invalidate()

        if text.isEmpty {
            interactor?.fetchPreviousKeywords()
        } else {
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerDidFire(_:)), userInfo: text, repeats: false)
        }
    }
    
    func searchButtonDidEnter(_ text: String) {
        
        timer?.invalidate()
        
        interactor?.saveKeyword(text)
        view?.showLoadingIndicator()
        interactor?.fetchSearchArticles(with: text)
    }
    
    // MARK: === INTERACTOR EVENTS ===
    func didFetchKeywords(_ keywords: [String]) {
        
        let sections = keywords.map {
            SearchKeywordSection(keyword: $0)
        }
        
        DispatchQueue.main.async { [weak self] in
            
            self?.view?.reloadView(with: sections)

            if sections.isEmpty {
                self?.view?.showEmptyView()
            } else {
                self?.view?.hideEmptyView()
            }
        }
    }
    
    func didFetchSearchArticleSuccess(_ searchArticles: [SearchArticle]) {
        
        let sections = searchArticles.map {
            SearchArticleSection(title: $0.title, snippet: $0.snippet, publisher: $0.publisher)
        }
        
        DispatchQueue.main.async { [weak self] in
            
            self?.view?.hideLoadingIndicator()
            self?.view?.reloadView(with: sections)

            if sections.isEmpty {
                self?.view?.showEmptyView()
                
            } else {
                self?.view?.hideEmptyView()
            }
        }
    }
    
    func didFetchSearchArticlesError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoadingIndicator()
            self?.view?.showError(error)
        }
    }
    
    
    // MARK: === PRIVATE ===
    @objc private func timerDidFire(_ timer: Timer) {
        if  let text = timer.userInfo as? String {
            view?.showLoadingIndicator()
            interactor?.fetchSearchArticles(with: text)
        }
    }
}
