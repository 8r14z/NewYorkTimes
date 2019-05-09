//
//  SearchProtocol.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



protocol SearchViewProtocol: ClassOnly {
    
    var presenter: SearchPresenterProtocol? { get set }
    
    func showError(_ error: Error)
    func showEmptyView()
    func hideEmptyView()
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func setSearchBarTextPlaceholder(_ text: String)
    func removeFocusOnSearchBar()
    
    func currentSearchText() -> String?

    func reloadView(with data: [SectionViewModel])
}



protocol SearchPresenterProtocol: ClassOnly {
    
    var view: SearchViewProtocol? { get set }
    var interactor: SearchInteractorProtocol? { get set }
    var router: SearchRouterProtocol? { get set }
    
    func searchBarDidBeginEditing()
    func didSelectSearchKeyword(_ keyword: String)
    func searchTextDidChange(_ text: String)
    func searchButtonDidEnter(_ text: String)
    
    // Interactor Listener
    func didFetchKeywords(_ keywords: [String])
    func didFetchSearchArticleSuccess(_ searchArticles: [SearchArticle])
    func didFetchSearchArticlesError(_ error: Error)
}



protocol SearchInteractorProtocol: ClassOnly {

    var presenter: SearchPresenterProtocol? { get set }
    var repository: SearchArticleRepository { get set }
    
    func fetchPreviousKeywords()
    func saveKeyword(_ keyword: String)
    func fetchSearchArticles(with keyword: String)
}



protocol SearchRouterProtocol: ClassOnly {
    
    static func makeSearchView() -> UISearchController
}
