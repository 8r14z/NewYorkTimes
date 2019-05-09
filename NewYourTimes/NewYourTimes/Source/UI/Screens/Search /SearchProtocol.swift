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
    
    func showEmptyView()
    func hideEmptyView()
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func reloadView(with data: [SearchArticle])
    func updateView(with newData: [SearchArticle])
}



protocol SearchPresenterProtocol: ClassOnly {
    
    var view: SearchViewProtocol? { get set }
    var interactor: SearchInteractorProtocol? { get set }
    var rounter: SearchRouterProtocol? { get set }
    
    func searchBarDidBeginEditing()
    func didSelectSearchKeyword(_ keyword: String)
    func searchTextDidChange(_ text: String?)
    func searchButtonDidSelect(_ text: String)
    
    func didSelectSection(_ section: HomeArticleSection)
    func willDisplaySection(_ section: HomeArticleSection, sectionIndex: Int, sectionCount: Int)
    
    // Interactor Listener
    func didFetchKeywords(_ keywords: [String]?)
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
