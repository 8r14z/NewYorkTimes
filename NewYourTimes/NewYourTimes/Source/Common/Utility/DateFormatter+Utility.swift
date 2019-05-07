//
//  DateFormatter+Utility.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



extension DateFormatter {
    
    enum DateFormat: String {
        
        case iso8601Date = "yyyy-MM-dd"
        case iso8601DateAndTime = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        
        var pattern: String {
            return rawValue
        }
    }
    
    convenience init(format: DateFormat) {
        self.init()
        dateFormat = format.pattern
    }
}


typealias DateFormat = DateFormatter.DateFormat
