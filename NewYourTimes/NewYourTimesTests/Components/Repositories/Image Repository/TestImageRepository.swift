//
//  TestImageRepository.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestImageRepository: XCTestCase {
    
    let imageRepository = ImageRepository(local: MockImageLocalDataSource(),
                                          remote: MockImageRemoteDataSource())
    
    func testRetrieveImage() {
        
        let url = TestURL
        var success = false
        let promise = expectation(description: "")
        
        imageRepository.image(for: url) { (image) in
            
            if let _ = image {
                success = true
            }
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(success)
    }
    
}
