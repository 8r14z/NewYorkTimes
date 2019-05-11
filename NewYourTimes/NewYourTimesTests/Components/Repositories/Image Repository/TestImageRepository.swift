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
    
    
    func testRetrieveImageFromRemoteSuccess() {
        
        let imageRepository = ImageRepository(local: MockImageLocalDataSource(available: false),
                                              remote: MockImageRemoteDataSource(response: .hit))
        
        let url = TestURL
        var testImage: UIImage?
        let promise = expectation(description: "")
        
        imageRepository.image(for: url) { (image) in
            
            if let image = image {
                testImage = image
            }
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(testImage)
    }
    
    func testRetrieveImageFromRemoteEmpty() {
        
        let imageRepository = ImageRepository(local: MockImageLocalDataSource(available: false),
                                              remote: MockImageRemoteDataSource(response: .miss))
        
        let url = TestURL
        var testImage: UIImage?
        let promise = expectation(description: "")
        
        imageRepository.image(for: url) { (image) in
            
            if let image = image {
                testImage = image
            }
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(testImage)
    }
    
    func testRetrieveImageFromRemoteError() {
        
        let imageRepository = ImageRepository(local: MockImageLocalDataSource(available: false),
                                              remote: MockImageRemoteDataSource(response: .error))
        
        let url = TestURL
        var testImage: UIImage?
        let promise = expectation(description: "")
        
        imageRepository.image(for: url) { (image) in
            
            if let image = image {
                testImage = image
            }
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(testImage)
    }
    
    func testRetrieveImageFromLocal() {
        
        let imageRepository = ImageRepository(local: MockImageLocalDataSource(available: true),
                                              remote: MockImageRemoteDataSource(response: .miss))
        
        let url = TestURL
        var testImage: UIImage?
        let promise = expectation(description: "")
        
        imageRepository.image(for: url) { (image) in
            
            if let image = image {
                testImage = image
            }
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(testImage)
    }
    
    func testRetrieveImageFromInMemoryCache() {
        
        let imageRepository = ImageRepository(local: MockImageLocalDataSource(available: true),
                                              remote: MockImageRemoteDataSource(response: .miss))
        
        let url = TestURL
        var testImage: UIImage?
        let promise = expectation(description: "")
        
        imageRepository.image(for: url) { (image) in
            
            if let _ = image {
                imageRepository.image(for: url, completion: { (image) in
                    if let image = image {
                        testImage = image
                    }
                    promise.fulfill()
                })
            } else {
                promise.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(testImage)
    }
}
