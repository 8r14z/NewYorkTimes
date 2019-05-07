//
//  HomeProtocol.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



protocol HomeViewProtocol: UIViewController {
    
    var presenter: HomePresenterProtocol { get set }
    
    func reloadView(with data: [HomeArticleSection])
    func updateView(with newData: [HomeArticleSection])
}



protocol HomePresenterProtocol {
    
    var view: HomeViewProtocol { get set }
    var interactor: HomeInteractorProtocol { get set }
    var router: HomeRouterProtocol { get set }
    
    func viewDidLoad()
    func didEndDisplayItem(at index: Int, inTotal total: Int)
    func didPullToRefresh()
    
    // Interactor listener
    func didFetchArticles(_ articles: [Article])
}



protocol HomeInteractorProtocol {
    
    var presenter: HomePresenterProtocol { get set }
    
    func fetchArticles()
}



protocol HomeRouterProtocol {
    
    func navigateToSearchArticleView(from view: HomeViewProtocol)
    func navigateToArticleView(from view: HomeViewProtocol)
}
