//
//  TestSearchInteractor.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestSearchInteractor: XCTestCase {
    
    var presenter: MockSearchPresenter!
    var interactor: SearchInteractor!
    
    override func setUp() {
        super.setUp()
        
        presenter = MockSearchPresenter()
        interactor = SearchInteractor()
        interactor.presenter = presenter
    }
    
    func testFetchPreviousKeywords() {
        
        let repository = MockSearchRepository(response: .error)
        interactor.repository = repository
        
        
        
    }
}
