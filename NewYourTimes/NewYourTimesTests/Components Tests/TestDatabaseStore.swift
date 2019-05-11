//
//  TestDatabaseStore.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestDataBaseStore: XCTestCase {
    
    var dbStore: DatabaseStoring!
    let dbKey = "TestKey"
    
    override func setUp() {
        dbStore = UserDefaults.standard
    }
    
    override func tearDown() {
        UserDefaults.standard.removeAllData(forKey: dbKey)
        dbStore = nil
    }
    
    func testFetchAndSaveData() {
        
        let s1 = "String1"
        let s2 = "String2"
        dbStore.saveData(s1, forKey: dbKey)
        dbStore.saveData(s2, forKey: dbKey)
        
        let data = dbStore.fetchData(forKey: dbKey)
        
        XCTAssertNotNil(data)
        XCTAssertTrue(data!.count == 2)
        XCTAssertTrue(data! is [String])
        
        let r1 = data![0] as! String
        let r2 = data![1] as! String
        
        XCTAssertTrue(r1 == s1 && r2 == s2 || r1 == s2 && r2 == s1)
    }
    
    func testRemoveData() {
        
        let s1 = "String1"
        let s2 = "String2"
        dbStore.saveData(s1, forKey: dbKey)
        dbStore.saveData(s2, forKey: dbKey)
        
        dbStore.removeAllData(forKey: dbKey)
        
        let data = dbStore.fetchData(forKey: dbKey)
        
        XCTAssertNil(data)
    }
    
}
