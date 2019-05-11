//
//  SearchInteractor.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



class SearchInteractor: SearchInteractorProtocol {
    
    weak var presenter: SearchPresenterProtocol?
    var repository: SearchArticleRepositoryProtocol = SearchArticleRepository()
    
    func fetchPreviousKeywords() {
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            var keywords = self.repository.getPreviousSearchTerms() ?? []
            
            if keywords.count >= 10 {
                keywords = Array(keywords[0...9])
            }
            
            self.presenter?.didFetchKeywords(keywords)
        }
    }
    
    func saveKeyword(_ keyword: String) {
        
        DispatchQueue.global().async { [weak self] in
            self?.repository.saveSearchTerm(keyword)
        }
    }
    
    func fetchSearchArticles(with keyword: String) {

        // Do sth... Cancel previous search if same keyword...
        repository.fetchSearchArticles(query: keyword, pageIndex: 0) { [weak self] (result) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let articles):
                self.presenter?.didFetchSearchArticleSuccess(articles)
            case .failure(let error):
                self.presenter?.didFetchSearchArticlesError(error)
            }
        }
    }
}
