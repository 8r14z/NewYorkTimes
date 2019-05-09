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
    var repository: SearchArticleRepository = SearchArticleRepository()
    
    private var previousKeyword: String = ""
    private var pageIndex: Int = 0
    
    private let serialQueue = DispatchQueue(label: "SearchInteractorSerialQueue")

    func fetchPreviousKeywords() {
        let keywords = repository.getPreviousSearchTerms()
        presenter?.didFetchKeywords(keywords)
    }
    
    func saveKeyword(_ keyword: String) {
        repository.saveSearchTerm(keyword)
    }
    
    func fetchSearchArticles(with keyword: String) {

        serialQueue.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.repository.fetchSearchArticles(query: keyword, pageIndex: self.pageIndex) { [weak self] (result) in
                
                self?.serialQueue.async { [weak self] in
                    
                    
                }
            }
        }
    }
}
