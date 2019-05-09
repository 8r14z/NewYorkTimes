//
//  ACVViewController.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit

class ACVViewController: UICollectionViewController {
    
    lazy private(set)var acvAdapter: ACVAdapter = {
        let adapter = ACVAdapter()
        adapter.collectionView = collectionView
        return adapter
    }()
    
    lazy private(set)var refreshControl: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return refresher
    }()
    
    lazy private(set)var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        indicator.constraintCenter(to: view)
        return indicator
    }()
    
    lazy private(set)var emptyLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        view.addSubview(label)
        label.constraintEqual(to: view)
        return label
    }()
    
    var isPullToRefreshEnabled: Bool {
        return true
    }

    init() {
        
        let flowLayout = ACVFlowLayout()
            .autoSizing(false)
            .minimumLineSpacing(0)
            .sectionInset(top: 0, left: 0, bottom: 10, right: 0)
        
        super.init(collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isPullToRefreshEnabled {
            collectionView.addSubview(refreshControl)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    /// To override by sub class
    func didPullToRefreshSections() { }
    
    @objc private func didPullToRefresh() {
        didPullToRefreshSections()
    }
}
