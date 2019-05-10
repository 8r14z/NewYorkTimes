//
//  ArticleProtocol.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



protocol ArticleViewProtocol: ClassOnly {
    
    var presenter: ArticlePresenterProtocol? { get set }
    
    func updateViewWithArticle(_ article: ArticleDetailSection)
}



protocol ArticlePresenterProtocol: ClassOnly {
    
    var currentIndex: Int { get }
    
    var currentArticle: ArticleDetailSection? { get }
    var nextArticle: ArticleDetailSection? { get }
    var previousArticle: ArticleDetailSection? { get }
    
    var view: ArticleViewProtocol? { get set }
    var interactor: ArticleInteractorProtocol? { get set }
    
    func initialSetup()
    func willTransitionToArticle(_ article: ArticleDetailSection)
    
    // Interactor listener
    func didIntialFetchDone(_ article: Article, index: Int)
    func didLoadNextArticle(_ article: Article?, index: Int)
    func didLoadPreviousArticle(_ article: Article?, index: Int)
}


protocol ArticleInteractorProtocol: ClassOnly {
    
    var presenter: ArticlePresenterProtocol? { get set }
    var repository: ArticleRepositoryProtocol { get set }

    func intialFetchArticle(at index: Int)
    func loadNextArticle(for index: Int)
    func loadPreviousArticle(for index: Int)
}



protocol ArticleRouterProtocol: ClassOnly {
    
    static func makeArticleView(currentIndex index: Int) -> UIViewController
}

