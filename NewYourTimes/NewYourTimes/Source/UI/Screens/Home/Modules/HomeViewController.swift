//
//  HomeViewController.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class HomeViewController: UICollectionViewController, HomeViewProtocol {

    var presenter: HomePresenterProtocol?

    lazy var acvAdapter: ACVAdapter = {
        return ACVAdapter()
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return refresher
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var articleSections = [HomeArticleSection]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = ACVFlowLayout()
            .autoSizing(false)
            .minimumLineSpacing(0)
            .sectionInset(top: 0, left: 0, bottom: 10, right: 0)
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.addSubview(refreshControl)
        
        view.addSubview(loadingIndicator)
        loadingIndicator.constraintCenter(to: view)
        
        navigationItem.title = "News".localized()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        acvAdapter.collectionView = collectionView
        acvAdapter.dataSource = self
        acvAdapter.delegate = self
        
        presenter?.viewDidAppear()
    }
    
    override class func storyboardName() -> String {
        return "Home"
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
    
    @objc func didPullToRefresh() {
        presenter?.didPullToRefresh()
    }
}



