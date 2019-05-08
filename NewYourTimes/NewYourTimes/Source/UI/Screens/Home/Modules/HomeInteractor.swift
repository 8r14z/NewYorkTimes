//
//  HomeInteractor.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



class HomeInteractor: HomeInteractorProtocol {
    
    weak var presenter: HomePresenterProtocol?
    
    private let pageSize = API.Default.pageSize
    private var pageOffset: UInt = 0
    
    private let serialQueue = DispatchQueue(label: "HomeInteractorSerialQueue")
    
    lazy var articleRepository = ArticleRepository.shared
    
    
    func initialFetchArticles() {
        fetch(with: 0, pageSize: pageSize, isInitialFetch: true)
    }

    func fetchArticles() {
        fetch(with: pageOffset, pageSize: pageSize, isInitialFetch: false)
    }
    
    private func fetch(with pageOffset: UInt, pageSize: UInt, isInitialFetch: Bool) {
        
        articleRepository.fetchArticles(pageOffset: pageOffset, pageSize: pageSize, fetchStrategy: .serverOnly) { [weak self] (result) in
            
            self?.serialQueue.async { [weak self] in
                
                guard let self = self else {
                    return
                }
                
                self.pageOffset += self.pageSize
                
                switch result {
                case .success(let articles):
                    
                    if isInitialFetch {
                        self.presenter?.didInitialFetchSuccess(articles)
                    } else {
                        self.presenter?.didFetchSuccess(articles)
                    }
                    
                case .failure(let error):
                    self.presenter?.didFetchError(error)
                }
            }
        }
    }
}
