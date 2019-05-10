//
//  ArticleViewController.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class ArticlesViewController: UIPageViewController {
    
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
        } else {
            // Fallback on earlier versions
        }
        
        dataSource = self
    }
    
}



extension ArticlesViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let articleDetailSection = ArticleDetailSection(title: "[1] For His 200th Birthday, a Composer Gets a Closer Look", publishedDate: Date(), publisher: "International New York Times", author: "By REBECCA SCHMID", snippet: "As the bicentenary of Jacques Offenbach’s birth approaches, opera companies across Europe have been staging some of his rarely performed works.", image: Image(url: "", format: .mediumThreeByTwo440, caption: "Jacques Offenbach often conducted his own compositions and worked closely with his librettists.", width: 440, height: 293))
        
        
        let xxx = ArticleDetailViewController(articleSection: articleDetailSection)
        return xxx
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let articleDetailSection = ArticleDetailSection(title: "[2] For His 200th Birthday, a Composer Gets a Closer Look", publishedDate: Date(), publisher: "International New York Times", author: "By REBECCA SCHMID", snippet: "As the bicentenary of Jacques Offenbach’s birth approaches, opera companies across Europe have been staging some of his rarely performed works.", image: Image(url: "", format: .mediumThreeByTwo440, caption: "Jacques Offenbach often conducted his own compositions and worked closely with his librettists.", width: 440, height: 293))
        
        
        let xxx = ArticleDetailViewController(articleSection: articleDetailSection)
        return xxx
    }
    
    
}
