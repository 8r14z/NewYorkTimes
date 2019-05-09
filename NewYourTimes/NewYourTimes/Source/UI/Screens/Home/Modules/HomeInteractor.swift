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
    lazy var repository: ArticleRepositoryProtocol = ArticleRepository.shared

    private let pageSize = API.Default.pageSize
    private var pageOffset: Int = 0
    
    private let mutex = DispatchSemaphore(value: 1)
    
    func initialFetchArticles() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.mutex.wait()
            self.fetch(with: 0, pageSize: self.pageSize, isInitialFetch: true)
        }
    }

    func fetchArticles() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.mutex.wait()
            self.fetch(with: self.pageOffset, pageSize: self.pageSize, isInitialFetch: false)
        }
    }
    
    private func fetch(with pageOffset: Int, pageSize: Int, isInitialFetch: Bool) {

        repository.fetchArticles(pageOffset: pageOffset, pageSize: pageSize, fetchStrategy: .serverOnly) { [weak self] (result) in
            
            guard let self = self else {
                return
            }
            
            self.pageOffset = pageOffset + pageSize
            
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
            
            self.mutex.signal()
        }
    }
}
