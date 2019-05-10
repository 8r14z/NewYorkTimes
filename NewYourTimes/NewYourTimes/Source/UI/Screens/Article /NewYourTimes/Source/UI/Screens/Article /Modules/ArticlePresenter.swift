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
    
    private(set) var currentIndex: Int
    
    private(set) var currentArticle: ArticleDetailSection?
    private(set) var previousArticle: ArticleDetailSection?
    private(set) var nextArticle: ArticleDetailSection?
    
    init(currentIndex: Int) {
        self.currentIndex = currentIndex
    }
    
    func initialSetup() {
        interactor?.loadFirstArticle(for: currentIndex)
    }
    
    func willTransitionToArticle(_ article: ArticleDetailSection) {

        guard let curArticle = currentArticle else {
            return
        }
        
        if article.pageIndex > curArticle.pageIndex {
            
            previousArticle = currentArticle
            currentArticle = article
            nextArticle = nil
            
            interactor?.loadNextArticle(for: article.pageIndex)
        } else {
            
            nextArticle = currentArticle
            currentArticle = article
            previousArticle = nil
            
            interactor?.loadPreviousArticle(for: article.pageIndex)
        }
    }
    
    func didLoadFirstArticle(_ article: Article, index: Int) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            let articleSection = self.convert(article, index: index)
            self.currentArticle = articleSection
            self.view?.updateViewWithArticle(articleSection)
            self.interactor?.loadNextArticle(for: index)
            self.interactor?.loadPreviousArticle(for: index)
        }
    }
    
    func didLoadNextArticle(_ article: Article?, index: Int) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            if let article = article {
                self.nextArticle = self.convert(article, index: index)
            } else {
                self.nextArticle = nil
            }
        }
    }
    
    func didLoadPreviousArticle(_ article: Article?, index: Int) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            if let article = article {
                self.previousArticle = self.convert(article, index: index)
            } else {
                self.previousArticle = nil
            }
        }
    }
    
    private func convert(_ article: Article, index: Int) -> ArticleDetailSection {
        return ArticleDetailSection(title: article.title,
                                    publishedDate: article.publishedDate,
                                    publisher: article.publisher,
                                    author: article.author,
                                    snippet: article.snippet,
                                    image: article.banner(),
                                    pageIndex: index)
    }
}
