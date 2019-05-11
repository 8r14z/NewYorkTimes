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
    
    private var cachedImage: UIImage?
    
    init(available: Bool = true) {
        if available {
            cachedImage = TestImage
        } else {
            cachedImage = nil
        }
    }
    
    func image(for url: URL) -> UIImage? {
        return cachedImage
    }
    
    func saveImage(_ image: UIImage, for url: URL) {
        cachedImage = image
    }
}
