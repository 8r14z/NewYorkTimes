//
//  MockURLSession.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/30/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation
@testable import NewYourTimes



class MockURLSession: URLSessionProtocol {
    
    private var response: Response
    init(response: Response) {
        self.response = response
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let url = URL(string: "url")!
        let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        switch response {
        case .hit:
            completionHandler(ArticleRawJSON, urlResponse, nil)
        case .miss:
            completionHandler(nil, urlResponse, nil)
        case .error:
            completionHandler(nil, urlResponse, TestError)
        }
        
        
        return URLSession.shared.dataTask(with: url)
    }
}
