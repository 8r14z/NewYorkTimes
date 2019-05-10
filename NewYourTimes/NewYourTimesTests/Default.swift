//
//  Default.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes


let imageJSON: JSON = [
    "url": "https://static01.nyt.com/images/2019/05/10/opinion/10eganWeb/10eganWeb-thumbStandard.jpg",
    "format": "Standard Thumbnail",
    "caption": "The unveiling of President Barack Obama Boulevard in Los Angeles on Saturday.",
    "height": 75,
    "width": 75
]

let articleJSON: JSON = [
    "title": "A Founder of Facebook Says It’s Time to Break It Up",
    "abstract": "We talked to Chris Hughes, who says the government must intervene to rein in the power of the company he helped to start.",
    "updatedDate": "2019-05-10T06:08:12-04:00",
    "published_date": "2019-05-09T20:00:00-04:00",
    "byline": "The New Your Times",
    "source": "The New York Times",
    "multimedia": [imageJSON]
]

let TestURL = URL(string: "https://www.google.com/")!

let TestImage = UIImage.init(named: "image.jpg", in: Bundle.init(for: MockImageProvider.self), compatibleWith: nil)!
