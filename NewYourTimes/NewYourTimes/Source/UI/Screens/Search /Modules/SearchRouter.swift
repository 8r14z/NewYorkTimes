//
//  SearchResultRouter.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class SearchRouter: SearchRouterProtocol {
    
    static func makeSearchView() -> UISearchController {
        
        let view = SearchViewController()
        let presenter = SearchPresenter()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        let searchController = UISearchController(searchResultsController: view)
        searchController.searchResultsUpdater = view
        searchController.searchBar.delegate = view
        view.searchBar = searchController.searchBar
        
        return searchController
    }
}
