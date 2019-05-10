//
//  TestImageRemoteDataSource.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestImageRemoteDataSource: XCTestCase {
    
    var remoteDataSource = ImageRemoteDataSource(serviceProvider: MockImageProvider())
    
    func testImageDownload() {
        
        let url = TestURL
        var success = false
        let promise = expectation(description: "")
        
        remoteDataSource.image(for: url) { (result) in
            
            if let _ = try? result.get() {
                success = true
            }
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(success)
    }
}
