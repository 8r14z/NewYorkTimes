//
//  ArticlePresenter.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



class ArticlePresenter: ArticlePresenterProtocol {
    
    weak var view: ArticleViewProtocol?
    var interactor: ArticleInteractorProtocol?
    
    var currentIndex: Int
    
    init(currentIndex: Int) {
        self.currentIndex = currentIndex
    }
    
    func viewDidLoad() {
        interactor?.loadArticle(for: currentIndex)
    }
    
    func prepareNextSection(for section: ArticleDetailSection) {
        interactor?.loadNextArticle(for: section.pageIndex)
    }
    func preparePreviousSection(for section: ArticleDetailSection) {
        interactor?.loadPreviousArticle(for: section.pageIndex)
    }
    
    func didLoadCurrentArticle(_ article: Article, index: Int) {
        
        DispatchQueue.main.async { [weak self] in
            
            let section = ArticleDetailSection(title: article.title,
                                               publishedDate: article.publishedDate,
                                               publisher: article.publisher,
                                               author: article.author,
                                               snippet: article.snippet,
                                               image: article.banner(),
                                               pageIndex: index)
            
            self?.view?.updateViewWithCurrentSection(section)
        }
    }
    
    func didLoadNextArticle(_ article: Article?, index: Int) {
        
        DispatchQueue.main.async { [weak self] in
            
            if let article = article {
                
                let section = ArticleDetailSection(title: article.title,
                                                   publishedDate: article.publishedDate,
                                                   publisher: article.publisher,
                                                   author: article.author,
                                                   snippet: article.snippet,
                                                   image: article.banner(),
                                                   pageIndex: index)
                
                self?.view?.updateViewWithNextSection(section)
            } else {
                self?.view?.updateViewWithNextSection(nil)
            }
        }
    }
    
    func didLoadPreviousArticle(_ article: Article?, index: Int) {
        
        DispatchQueue.main.async { [weak self] in
            
            if let article = article {
                
                let section = ArticleDetailSection(title: article.title,
                                                   publishedDate: article.publishedDate,
                                                   publisher: article.publisher,
                                                   author: article.author,
                                                   snippet: article.snippet,
                                                   image: article.banner(),
                                                   pageIndex: index)
                
                self?.view?.updateViewWithPreviousSection(section)
            } else {
                self?.view?.updateViewWithPreviousSection(nil)
            }
        }
    }
}
