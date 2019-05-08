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
    
    func performUpdateView()
}



protocol HomePresenterProtocol: ClassOnly {
    
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func viewDidAppear()
    func didPullToRefresh()
    func didSelectSection(_ section: Int)
    func willDisplaySection(_ section: Int)
    
    // Interactor listener
    func didInitialFetchSuccess(_ articles: [Article])
    func didFetchSuccess(_ articles: [Article])
    func didFetchError(_ error: Error)
}



protocol HomeInteractorProtocol: ClassOnly {
    
    var presenter: HomePresenterProtocol? { get set }
    
    func initialFetchArticles() 
    func fetchArticles()
}



protocol HomeRouterProtocol: ClassOnly {
    
    static func makeHomeView() -> UIViewController
    
    func navigateToSearchArticleView(from view: HomeViewProtocol)
    func navigateToArticleView(from view: HomeViewProtocol)
}
