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
    
    
    func testImageDownloadSuccess() {
        
        let remoteDataSource = ImageRemoteDataSource(serviceProvider: MockServiceProvider(response: .hit))
        
        let url = TestURL
        var testImage: UIImage?
        let promise = expectation(description: "")
        
        remoteDataSource.image(for: url) { (result) in
            
            if let image = try? result.get() {
                testImage = image
            }
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(testImage)
    }
    
    func testImageDownloadEmpty() {
        
        let remoteDataSource = ImageRemoteDataSource(serviceProvider: MockServiceProvider(response: .miss))
        
        let url = TestURL
        var testImage: UIImage?
        let promise = expectation(description: "")
        
        remoteDataSource.image(for: url) { (result) in
            
            if let image = try? result.get() {
                testImage = image
            }
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(testImage)
    }
    
    func testImageDownloadFail() {
        
        let remoteDataSource = ImageRemoteDataSource(serviceProvider: MockServiceProvider(response: .error))
        
        let url = TestURL
        var testImage: UIImage?
        var testError: Error?
        let promise = expectation(description: "")
        
        remoteDataSource.image(for: url) { (result) in
            
            switch result {
            case .success(let image):
                testImage = image
            case.failure(let error):
                testError = error
            }
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(testImage)
        XCTAssertNotNil(testError)
    }
}
