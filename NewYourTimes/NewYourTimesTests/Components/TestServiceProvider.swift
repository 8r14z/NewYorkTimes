//
//  TestServiceProvider.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/10/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestServiceProvider: XCTestCase {
    
    var serviceProvider: ServiceProviding!
    
    override func setUp() {
        serviceProvider = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        serviceProvider = nil
    }
    
    func testDownloadDataWithValidURL() {
        
        let url = URL(string: "https://www.google.com/")!
        
        var success = false
        let promise = expectation(description: "")

        serviceProvider.downloadData(with: url) { (result) in
            if let _ = try? result.get() {
                success = true
            }
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(success)
    }
    
    func testDownDataWithInvalidURL() {
        
        let url = URL(string: "https://www.thisisinvaliddomain.com/")!
        
        var success = false
        let promise = expectation(description: "")
        
        serviceProvider.downloadData(with: url) { (result) in
            if let _ = try? result.get() {
                success = true
            }
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(success)
    }
    
    func testDownloadJSON() {
        
        let api = API.article(offset: 0, pageSize: 1)
        
        var success = false
        let promise = expectation(description: "")

        serviceProvider.download(with: api.url) { (result) in
            
            if let _ = try? result.get() {
                success = true
            }
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(success)
    }
    
    func testDownloadJSONInvalidURL() {
        
        let url = URL(string: "https://www.thisisinvaliddomain.com/")!

        var success = false
        let promise = expectation(description: "")
        
        serviceProvider.download(with: url) { (result) in
            
            if let _ = try? result.get() {
                success = true
            }
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(success)
    }
}
