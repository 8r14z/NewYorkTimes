//
//  MockArticlePresenter.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation
@testable import NewYourTimes



class MockArticlePresenter: ArticlePresenterProtocol {
    
    var currentIndex: Int = 0
    
    var currentArticle: ArticleDetailSection?
    var nextArticle: ArticleDetailSection?
    var previousArticle: ArticleDetailSection?
    
    var view: ArticleViewProtocol?
    var interactor: ArticleInteractorProtocol?
    
    var didFetchFirstArticleSucess = false
    var didFetchFirstArticleError = false

    var didFetchNextArticle = false
    var didFetchPreviousArticle = false
    
    func initialSetup() {
        
    }
    
    func willTransitionToArticle(_ article: ArticleDetailSection) {
        
    }
    
    func didInitialFetchSuccess(_ article: Article, index: Int) {
        didFetchFirstArticleSucess = true
        currentArticle = ArticleDetailSection(title: article.title,
                                              publishedDate: article.publishedDate,
                                              publisher: article.publisher,
                                              author: article.author,
                                              snippet: article.snippet,
                                              image: article.banner(),
                                              pageIndex: index)
    }
    
    func didInitialFetchError(_ error: Error) {
        didFetchFirstArticleError = true
    }
    
    func didLoadNextArticle(_ article: Article?, index: Int) {
        
        didFetchNextArticle = true
        
        guard let article = article else {
            return
        }
        
        nextArticle = ArticleDetailSection(title: article.title,
                                           publishedDate: article.publishedDate,
                                           publisher: article.publisher,
                                           author: article.author,
                                           snippet: article.snippet,
                                           image: article.banner(),
                                           pageIndex: index)
    }
    
    func didLoadPreviousArticle(_ article: Article?, index: Int) {
        
        didFetchPreviousArticle = true
        
        guard let article = article else {
            return
        }
        
        previousArticle = ArticleDetailSection(title: article.title,
                                               publishedDate: article.publishedDate,
                                               publisher: article.publisher,
                                               author: article.author,
                                               snippet: article.snippet,
                                               image: article.banner(),
                                               pageIndex: index)
    }
    
}
