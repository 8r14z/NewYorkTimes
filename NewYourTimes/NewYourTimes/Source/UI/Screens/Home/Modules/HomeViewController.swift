//
//  HomeViewController.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class HomeViewController: ACVViewController, HomeViewProtocol {

    var presenter: HomePresenterProtocol?

    private var articleSections = [HomeArticleSection]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "News".localized()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        acvAdapter.dataSource = self
        acvAdapter.delegate = self
        
        presenter?.viewDidAppear()
    }
    
    override class func storyboardName() -> String {
        return "Home"
    }
    
    override func didPullToRefreshSections() {
        presenter?.didPullToRefresh()
    }
}



extension HomeViewController {
    
    func showError(_ error: Error) {
        
        let alertController = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(title: "OK", style: .cancel, handler: nil)
        )
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    func hidePullToRefreshIndicator() {
        refreshControl.endRefreshing()
    }
    
    func reloadView(with data: [HomeArticleSection]) {
        articleSections = data
        acvAdapter.reloadAllSections()
    }
    
    func updateView(with newData: [HomeArticleSection]) {
        articleSections.append(contentsOf: newData)
        acvAdapter.performUpdate()
    }
}



extension HomeViewController: ACVAdapterDataSource {
    
    func sectionViewModelsForAdapter(_ adapter: ACVAdapter) -> [SectionViewModel] {
        return articleSections
    }
}



// MARK: === USER INTERACTION ===
extension HomeViewController: ACVAdapterDelegate {

    func didSelectItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath) {
        presenter?.didSelectSection(articleSections[indexPath.section])
    }
    
    func willDisplaySection(section: Int) {
        presenter?.willDisplaySection(articleSections[section], sectionIndex: section, sectionCount: articleSections.count)
    }
}



