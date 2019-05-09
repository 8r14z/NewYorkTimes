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
    var rounter: SearchRouterProtocol?
    
    private var isFetchingArticles = false
    
    // MARK: === VIEW EVENTS ===
    func searchBarDidBeginEditing() {
        
    }
    
    func didSelectSearchKeyword(_ keyword: String) {
        
    }
    
    func searchTextDidChange(_ text: String?) {
        
    }
    
    func searchButtonDidSelect(_ text: String) {
        
    }
    
    func didSelectSection(_ section: HomeArticleSection) {
        
    }
    
    func willDisplaySection(_ section: HomeArticleSection, sectionIndex: Int, sectionCount: Int) {
        
    }
    
    // MARK: === INTERACTOR EVENTS ===
    func didFetchKeywords(_ keywords: [String]?) {
        
    }
    
    func didFetchSearchArticleSuccess(_ searchArticles: [SearchArticle]) {
        
    }
    
    func didFetchSearchArticlesError(_ error: Error) {
        
    }
    
  
    
}
