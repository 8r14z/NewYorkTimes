//
//  ArticleInteractor.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



class ArticleInteractor: ArticleInteractorProtocol {
    
    weak var presenter: ArticlePresenterProtocol?
    lazy var repository: ArticleRepositoryProtocol = ArticleRepository.shared
    
    private let pageSize = 1
    
    func loadFirstArticle(for index: Int) {
        
        repository.fetchArticles(pageOffset: index, pageSize: pageSize, fetchStrategy: .cacheOnly) { (result) in
            
            if let article = try? result.get().first {
                self.presenter?.didLoadFirstArticle(article, index: index)
            }
        }
    }
    
    func loadNextArticle(for index: Int) {
        
        let nextIndex = index + 1
        repository.fetchArticles(pageOffset: nextIndex, pageSize: pageSize, fetchStrategy: .cacheOnly) { (result) in
            
            if let article = try? result.get().first {
                self.presenter?.didLoadNextArticle(article, index: nextIndex)
            } else {
                self.presenter?.didLoadNextArticle(nil, index: nextIndex)
            }
        }
    }
    
    func loadPreviousArticle(for index: Int) {
        
        let previousIndex = index - 1
        repository.fetchArticles(pageOffset: previousIndex, pageSize: pageSize, fetchStrategy: .cacheOnly) { (result) in
            
            if let article = try? result.get().first {
                self.presenter?.didLoadPreviousArticle(article, index: previousIndex)
            } else {
                self.presenter?.didLoadPreviousArticle(nil, index: previousIndex)
            }
        }
    }
    
}
