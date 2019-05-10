//
//  ArticleRouter.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class ArticleRouter: ArticleRouterProtocol {
    
    static func makeArticleView(currentIndex index: Int) -> UIViewController {
        
        let view = ArticleViewController()
        let presenter = ArticlePresenter(currentIndex: index)
        let interactor = ArticleInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }

}
