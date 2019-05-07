//
//  JSONDecoder+Utility.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



extension JSONDecoder {
    
    convenience init(dateDecodingFormat: DateFormat) {
        self.init()
        let dateFormatter = DateFormatter(format: dateDecodingFormat)
        dateDecodingStrategy = .formatted(dateFormatter)
    }
    
    func decode<T>(_ type: T.Type, from json: Any) throws -> T where T : Decodable {
        let data = try JSONSerialization.data(withJSONObject: json)
        return try decode(type, from: data)
    }
}
