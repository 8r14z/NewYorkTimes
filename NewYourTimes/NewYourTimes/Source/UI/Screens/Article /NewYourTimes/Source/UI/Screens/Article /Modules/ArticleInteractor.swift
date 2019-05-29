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
    var requestQueue = DispatchQueue.global()
    
    private let pageSize = 1
    
    func intialFetchArticle(at index: Int) {
        
        requestQueue.async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            self.repository.fetchArticles(pageOffset: index, pageSize: self.pageSize, fetchStrategy: .cacheOnly) { [weak self] (result) in
                
                guard let self = self else {
                    return
                }
                
                if let article = try? result.get().first {
                    self.presenter?.didInitialFetchSuccess(article, index: index)
                } else {
                    self.presenter?.didInitialFetchError(NetworkError.unexpected)
                }
            }
        }
    }
    
    func loadNextArticle(for index: Int) {
        
        requestQueue.async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            let nextIndex = index + 1
            self.repository.fetchArticles(pageOffset: nextIndex, pageSize: self.pageSize, fetchStrategy: .cacheOnly) { [weak self] (result) in
                
                guard let self = self else {
                    return
                }
                
                if let article = try? result.get().first {
                    self.presenter?.didLoadNextArticle(article, index: nextIndex)
                } else {
                    self.presenter?.didLoadNextArticle(nil, index: nextIndex)
                }
            }
        }
        
    }
    
    func loadPreviousArticle(for index: Int) {
        
        requestQueue.async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            let previousIndex = index - 1
            self.repository.fetchArticles(pageOffset: previousIndex, pageSize: self.pageSize, fetchStrategy: .cacheOnly) { [weak self] (result) in
                
                guard let self = self else {
                    return
                }
                
                if let article = try? result.get().first {
                    self.presenter?.didLoadPreviousArticle(article, index: previousIndex)
                } else {
                    self.presenter?.didLoadPreviousArticle(nil, index: previousIndex)
                }
            }
        }
    }
}
