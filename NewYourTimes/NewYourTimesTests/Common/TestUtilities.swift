//
//  TestUtilities.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestUtilities: XCTestCase {
    
    func testMD5() {
        
        let string = "Hello"
        
        let result = string.md5()
        
        XCTAssert(result == "8b1a9953c4611296a827abf8c47804d7")
    }
    
    func testISO8601DateAndTimeFormatter() {
        
        let formatter = DateFormatter(format: .iso8601DateAndTime)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let string = "2019-05-11T00:00:00GMT"
        let dateFromString = formatter.date(from: string)
        
        let stringFromDate = formatter.string(from: dateFromString!)
        
        XCTAssert(string == stringFromDate)
    }
    
    func testISO8601DateFormatter() {
        
        let formatter = DateFormatter(format: .iso8601Date)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let string = "2019-05-11"
        let dateFromString = formatter.date(from: string)
        
        let stringFromDate = formatter.string(from: dateFromString!)
        
        XCTAssert(string == stringFromDate)
    }
    
    func testTextBoundingWidth() {
        
        let string = "This is a long string that uses to testing the function of computation width for text with existing height and font size"
        
        let result = string.width(for: 10, font: UIFont.systemFont(ofSize: 13))
  
        XCTAssert(result == 697)
    }
    
    func testTextBoundingHeight() {
        
        let string = "This is a long string that uses to testing the function of computation width for text with existing height and font size"
        
        let result = string.height(for: 100, font: UIFont.systemFont(ofSize: 13))

        XCTAssert(result == 140)
    }
    
    func testJSONDecoderWithISO8601DateTimeFormat() {
        
        let data = ArticleRawJSON
        let decoder = JSONDecoder(dateDecodingFormat: .iso8601DateAndTime)
        
        let article = try! decoder.decode(Article.self, from: data)
        
        XCTAssertNotNil(article.publishedDate)
    }
    
    func testImageJPEGDecoding() {
        
        let image = TestImage
        
        let result = image.decoded()
        
        XCTAssertNotNil(result)
    }
}
