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
    
    func initViewWithSection(_ section: ArticleDetailSection)
    func updateViewWithNextSection(_ section: ArticleDetailSection?)
    func updateViewWithPreviousSection(_ section: ArticleDetailSection?)
}



protocol ArticlePresenterProtocol: ClassOnly {
    
    var currentIndex: Int { get set }
    
    var view: ArticleViewProtocol? { get set }
    var interactor: ArticleInteractorProtocol? { get set }
    
    func initialSetup()
    
    func prepareNextSection(for section: ArticleDetailSection)
    func preparePreviousSection(for section: ArticleDetailSection)
    
    func didLoadFirstArticle(_ article: Article, index: Int)
    
    func didLoadNextArticle(_ article: Article?, index: Int)
    func didLoadPreviousArticle(_ article: Article?, index: Int)
}


protocol ArticleInteractorProtocol: ClassOnly {
    
    var presenter: ArticlePresenterProtocol? { get set }
    var repository: ArticleRepositoryProtocol { get set }

    func loadFirstArticle(for index: Int)
    
    func loadNextArticle(for index: Int)
    func loadPreviousArticle(for index: Int)
}



protocol ArticleRouterProtocol: ClassOnly {
    
    static func makeArticleView(currentIndex index: Int) -> UIViewController
}

