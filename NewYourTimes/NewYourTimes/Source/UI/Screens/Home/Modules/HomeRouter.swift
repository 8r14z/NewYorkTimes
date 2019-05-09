//
//  HomeRouter.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class HomeRouter: HomeRouterProtocol {
    
    static func makeHomeView() -> UIViewController {
        
        let view = HomeViewController()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToSearchArticleView(from view: HomeViewProtocol) {
        
        guard let viewController = view as? HomeViewController else {
            return
        }
        let searchController = UISearchController(searchResultsController: nil)
        viewController.present(searchController, animated: true, completion: nil)
    }
    
    func navigateToArticleView(from view: HomeViewProtocol) {
        
        guard let viewController = view as? HomeViewController else {
            return
        }
    }
}
