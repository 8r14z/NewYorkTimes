//
//  MockDataStore.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class MockDatabaseStore: DatabaseStoring {
    
    private var db: [String: Any]?
    
    init(available: Bool) {
        if available {
            db = ["s1": "string1",
                  "s2": "string2"]
        }
    }
    
    func fetchData(forKey key: String) -> [Any]? {
        return db?.values.map { $0 }
    }
    
    func saveData<T>(_ data: T, forKey key: String) {
        if db == nil {
            db = [:]
        }
        db![key] = data
    }
    
    func removeAllData(forKey key: String) {
        db?[key] = nil
    }
}
