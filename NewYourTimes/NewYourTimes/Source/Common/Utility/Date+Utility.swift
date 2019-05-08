//
//  Date+Utility.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



extension Date {
    
    var iso8601DateString: String {
        let dateFormatter = DateFormatter(format: .iso8601Date)
        return dateFormatter.string(from: self)
    }
    
    var iso8601DateAndTimeString: String {
        let dateFormatter = DateFormatter(format: .iso8601DateAndTime)
        return dateFormatter.string(from: self)
    }
}
