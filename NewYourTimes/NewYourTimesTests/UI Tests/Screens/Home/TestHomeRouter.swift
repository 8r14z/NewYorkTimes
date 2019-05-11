//
//  TestHomeRouter.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestHomeRouter: XCTestCase {
    
    var router: HomeRouter!
    
    override func setUp() {
        super.setUp()
        
        router = HomeRouter()
    }
    
    func testNavigateToArticleView() {
        
        let view = HomeViewController()
        let nc = UINavigationController(rootViewController: view)
        router.navigateToArticleView(from: view, sectionIndex: 1)
        
        let promise = expectation(description: "")
        DispatchQueue.main.async {
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssert(nc.topViewController is ArticleViewController)
    }
}
