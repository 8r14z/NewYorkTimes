//
//  HomeProtocol.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



protocol HomeViewProtocol: ClassOnly {
    
    var presenter: HomePresenterProtocol? { get set }
    
    func showError(_ error: Error)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func hidePullToRefreshIndicator()
    
    func reloadView(with data: [HomeArticleSection])
    func updateView(with newData: [HomeArticleSection])
}



protocol HomePresenterProtocol: ClassOnly {
    
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func viewDidAppear()
    func didPullToRefresh()
    func didSelectSection(_ section: HomeArticleSection, sectionIndex: Int)
    func willDisplaySection(_ section: HomeArticleSection, sectionIndex: Int, sectionCount: Int)
    func didSelectSearch()
    
    // Interactor listener
    func didInitialFetchSuccess(_ articles: [Article])
    func didIntialFetchError(_ error: Error)
    func didFetchSuccess(_ articles: [Article])
    func didFetchError(_ error: Error)
}



protocol HomeInteractorProtocol: ClassOnly {
    
    var presenter: HomePresenterProtocol? { get set }
    var repository: ArticleRepositoryProtocol { get set }
    
    func initialFetchArticles() 
    func fetchArticles()
}



protocol HomeRouterProtocol: ClassOnly {
    
    static func makeHomeView() -> UIViewController
    
    func navigateToSearchArticleView(from view: HomeViewProtocol)
    func navigateToArticleView(from view: HomeViewProtocol, sectionIndex: Int)
}
