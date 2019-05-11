//
//  TestImageLocalDataSource.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestImageLocalDataSource: XCTestCase {
    
    var localDataSource = ImageLocalDataSource(cacheDirectoryName: "testImages")
    
    override func tearDown() {
        
        if FileManager.default.fileExists(atPath: localDataSource.cacheDirectoryURL.path) {
            try? FileManager.default.removeItem(at: localDataSource.cacheDirectoryURL)
        }
    }
    
    func testReadAndWriteImage() {
        
        let url = TestURL
        let image = TestImage
        
        let nilImage = localDataSource.image(for: url)
        
        XCTAssertNil(nilImage)
        
        localDataSource.saveImage(image, for: url)
        
        Thread.sleep(forTimeInterval: 0.3)
        
        let notNilImage = localDataSource.image(for: url)
        
        XCTAssertNotNil(notNilImage)
    }
    
}


