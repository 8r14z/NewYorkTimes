//
//  MockImageLocalDataSource.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit
@testable import NewYourTimes


class MockImageLocalDataSource: ImageLocalDataSourceProtocol {
    
    private var cachedImage = [URL: UIImage]()
    
    func image(for url: URL) -> UIImage? {
        return cachedImage[url]
    }
    
    func saveImage(_ image: UIImage, for url: URL) {
        cachedImage[url] = image
    }
}
