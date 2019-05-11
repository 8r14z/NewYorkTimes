//
//  TestArticle.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestModels: XCTestCase {
    
    
    func testEncodeImage() {
        
        let json = ImageRawJSON
        let image = try? JSONDecoder().decode(Image.self, from: json)

        XCTAssertNotNil(image)
    }
    
    func testEncodeArticle() {
        
        let json = ArticleRawJSON
        let decoder = JSONDecoder(dateDecodingFormat: .iso8601DateAndTime)
        let article = try? decoder.decode(Article.self, from: json)

        XCTAssertNotNil(article)
    }
    
    func testEncodeSearchArticle() {
        
        let json = SearchArticleRawJSON
        let searchArticle = try? JSONDecoder().decode(SearchArticle.self, from: json)
        
        XCTAssertNotNil(searchArticle)
    }
}


