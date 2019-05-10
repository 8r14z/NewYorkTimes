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
        
        let searchController = viewController.searchController
        viewController.present(searchController, animated: true, completion: nil)
    }
    
    func navigateToArticleView(from view: HomeViewProtocol, sectionIndex: Int) {
        
        guard let viewController = view as? HomeViewController else {
            return
        }
        
        let articleDetailSection = ArticleDetailSection(title: "For His 200th Birthday, a Composer Gets a Closer Look", publishedDate: Date(), publisher: "International New York Times", author: "By REBECCA SCHMID", snippet: "As the bicentenary of Jacques Offenbach’s birth approaches, opera companies across Europe have been staging some of his rarely performed works.", image: Image(url: "", format: .mediumThreeByTwo440, caption: "Jacques Offenbach often conducted his own compositions and worked closely with his librettists.", width: 440, height: 293))
        
        
        let xxx = ArticleDetailViewController(articleSection: articleDetailSection)
        let vc = ArticleRounter.makeArticleView(currentSectionIndex: sectionIndex)
        vc.setViewControllers([xxx], direction: .forward, animated: false, completion: nil)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
