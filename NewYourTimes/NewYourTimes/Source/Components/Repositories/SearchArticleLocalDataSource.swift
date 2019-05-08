//
//  SearchArticleLocalDataSource.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



protocol SearchArticleLocalDataSourceProtocol {
    
    var dbStore: DatabaseStoring { get set }
    
    func fetchPreviousSearchTerms() -> [String]?
    func saveSearchTerm(_ searchTerm: String)
}



class SearchArticleLocalDataSource: SearchArticleLocalDataSourceProtocol {
    
    var dbStore: DatabaseStoring
    
    init(store: DatabaseStoring = UserDefaults.standard) {
        dbStore = store
    }
    
    func fetchPreviousSearchTerms() -> [String]? {
        if let result = dbStore.fetchData(forKey: Constants.searchArticleDBKey) as? [String] {
            return result
        }
        return nil
    }
    
    func saveSearchTerm(_ searchTerm: String) {
        dbStore.saveData(searchTerm, forKey: Constants.searchArticleDBKey)
    }
}
