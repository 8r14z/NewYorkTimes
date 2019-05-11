//
//  MockSearchView.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit
@testable import NewYourTimes



class MockSearchView: SearchViewProtocol {
    
    var presenter: SearchPresenterProtocol?
    
    var didShowError = false
    var didShowEmptyView = false
    var didHideEmptyView = false
    var didShowLoadingIndicator = false
    var didHideLoadingIndocator = false
    var didUpdateSearchBarText = false
    var searchText: String?
    var didResignFirstResponder = false
    var didReloadView = false
    
    var sectionModels: [SectionViewModel]?
    
    func showError(_ error: Error) {
        didShowError = true
    }
    
    func showEmptyView() {
        didShowEmptyView = true
    }
    
    func hideEmptyView() {
        didHideEmptyView = true
    }
    
    func showLoadingIndicator() {
        didShowLoadingIndicator = true
    }
    
    func hideLoadingIndicator() {
        didHideLoadingIndocator = true
    }
    
    func updateSearchBarText(_ text: String) {
        didUpdateSearchBarText = true
        searchText = text
    }
    
    func removeFocusOnSearchBar() {
        didResignFirstResponder = true
    }
    
    func reloadView(with data: [SectionViewModel]) {
        didReloadView = true
        sectionModels = data
    }
    
}
