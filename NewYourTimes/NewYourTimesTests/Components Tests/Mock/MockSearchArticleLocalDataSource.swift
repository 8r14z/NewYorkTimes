//
//  MockSearchArticleLocalDataSource.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class MockSearchArticleLocalDataSource: SearchArticleLocalDataSourceProtocol {
    
    var dbStore: DatabaseStoring
    private let dbkey = "SearchArticleTestKey"
    
    init(available: Bool) {
        dbStore = MockDatabaseStore(available: available)
    }
    
    func fetchPreviousSearchTerms() -> [String]? {
        return dbStore.fetchData(forKey: dbkey) as? [String]
    }
    
    func saveSearchTerm(_ searchTerm: String) {
        dbStore.saveData(searchTerm, forKey: dbkey)
    }
    
}



