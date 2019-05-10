//
//  ArticleViewController.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class ArticleViewController: UIPageViewController, ArticleViewProtocol {
    
    var presenter: ArticlePresenterProtocol?
    
    private var currentSection: ArticleDetailSection?
    private var previousSection: ArticleDetailSection?
    private var nextSection: ArticleDetailSection?
    
    init() {
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        view.backgroundColor = .separator
        dataSource = self
        
        presenter?.initialSetup()
    }
}



extension ArticleViewController  {
    
    func initViewWithSection(_ section: ArticleDetailSection) {
        
        let articleDetailVC = ArticleDetailView(articleSection: section)
        currentSection = section
        setViewControllers([articleDetailVC], direction: .forward, animated: false, completion: nil)
        
        presenter?.prepareNextSection(for: section)
        presenter?.preparePreviousSection(for: section)
    }

    func updateViewWithNextSection(_ section: ArticleDetailSection?) {
        nextSection = section
    }
    
    func updateViewWithPreviousSection(_ section: ArticleDetailSection?) {
        previousSection = section
    }
}



extension ArticleViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let section = previousSection {
            
            nextSection = currentSection
            currentSection = section
            previousSection = nil
            
            presenter?.preparePreviousSection(for: section)
            
            return ArticleDetailView(articleSection: section)

        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let section = nextSection {
            
            previousSection = currentSection
            currentSection = section
            nextSection = nil
            
            presenter?.prepareNextSection(for: section)
            
            return ArticleDetailView(articleSection: section)

        } else {
            return nil
        }
    }
}
