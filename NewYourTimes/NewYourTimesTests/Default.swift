//
//  Default.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



enum Response {
    case hit
    case miss
    case error
}


let TestError = NetworkError.unexpected


let ImageJSON: JSON = [
    "url": "https://static01.nyt.com/images/2019/05/10/opinion/10eganWeb/10eganWeb-thumbStandard.jpg",
    "format": "Standard Thumbnail",
    "caption": "The unveiling of President Barack Obama Boulevard in Los Angeles on Saturday.",
    "height": 75,
    "width": 75
]

let ArticleJSON: JSON = [
    "title": "A Founder of Facebook Says It’s Time to Break It Up",
    "abstract": "We talked to Chris Hughes, who says the government must intervene to rein in the power of the company he helped to start.",
    "updatedDate": "2019-05-10T06:08:12-04:00",
    "published_date": "2019-05-09T20:00:00-04:00",
    "byline": "The New Your Times",
    "source": "The New York Times",
    "multimedia": [ImageJSON]
]


let RawJSON = """
{
"results": [
{
"slug_name": "10xp-rapper",
"section": "U.S.",
"subsection": "",
"title": "Fugees Rapper Pras Michel and Financier Charged in Illegal Scheme to Raise Money for Obama",
"abstract": "The rapper Pras Michel and the fugitive Malaysian financier Low Taek Jho were charged with campaign finance violations in the 2012 election.",
"url": "https://www.nytimes.com/2019/05/10/us/pras-michel-jho-low-campaign-finance.html",
"byline": "By LIAM STACK",
"thumbnail_standard": "https://static01.nyt.com/images/2019/05/10/multimedia/10xp-rapper/10xp-rapper-thumbStandard.jpg",
"item_type": "Article",
"source": "The New York Times",
"updated_date": "2019-05-10T22:03:34-04:00",
"created_date": "2019-05-10T22:03:34-04:00",
"published_date": "2019-05-09T20:00:00-04:00",
"first_published_date": "2019-05-10T22:02:04-04:00",
"material_type_facet": "News",
"kicker": null,
"subheadline": null,
"des_facet": [
"Presidential Election of 2012",
"Campaign Finance",
"United States Politics and Government"
],
"org_facet": [
"Rap and Hip-Hop",
"Presidential Elections (US)",
"Fugitives",
"Corruption (Institutional)",
"Sovereign Wealth Funds",
"Ethics and Official Misconduct",
"1Malaysia Development Berhad (1MDB)",
"Federal Election Commission",
"Fugees (Music Group)",
"Justice Department",
"Goldman Sachs Group Inc"
],
"per_facet": [
"Najib Razak",
"Leissner, Tim",
"Ng, Roger",
"Obama, Barack",
"Pras"
],
"geo_facet": [
"Malaysia",
"United States"
],
"related_urls": [
{
"suggested_link_text": "Malaysia Opposition, Led by 92-Year-Old, Wins Upset Victory",
"url": "https://www.nytimes.com/2018/05/09/world/asia/malaysia-election-najib-mahathir.html"
},
{
"suggested_link_text": "Najib Razak, Malaysian Leader Toppled in 1MDB Scandal, Faces First Graft Trial",
"url": "https://www.nytimes.com/2019/04/03/world/asia/najib-case-malaysia.html"
},
{
"suggested_link_text": "Former Goldman Sachs Banker Pleads Not Guilty in Malaysia Fraud Case",
"url": "https://www.nytimes.com/2019/05/06/business/goldman-sachs-roger-ng-1mdb.html"
}
],
"multimedia": [
{
"url": "https://static01.nyt.com/images/2019/05/10/multimedia/10xp-rapper/10xp-rapper-thumbStandard.jpg",
"format": "Standard Thumbnail",
"height": 75,
"width": 75,
"type": "image",
"subtype": "photo",
"caption": "Pras Michel, one of the founding members of the hip-hop group the Fugees, is charged with federal campaign finance violations.",
"copyright": "Slaven Vlasic/Getty Images"
},
{
"url": "https://static01.nyt.com/images/2019/05/10/multimedia/10xp-rapper/e0bfc2783d474396bd048d1eb92e2c89-articleInline.jpg",
"format": "Normal",
"height": 129,
"width": 190,
"type": "image",
"subtype": "photo",
"caption": "Pras Michel, one of the founding members of the hip-hop group the Fugees, is charged with federal campaign finance violations.",
"copyright": "Slaven Vlasic/Getty Images"
},
{
"url": "https://static01.nyt.com/images/2019/05/10/multimedia/10xp-rapper/e0bfc2783d474396bd048d1eb92e2c89-mediumThreeByTwo210.jpg",
"format": "mediumThreeByTwo210",
"height": 140,
"width": 210,
"type": "image",
"subtype": "photo",
"caption": "Pras Michel, one of the founding members of the hip-hop group the Fugees, is charged with federal campaign finance violations.",
"copyright": "Slaven Vlasic/Getty Images"
},
{
"url": "https://static01.nyt.com/images/2019/05/10/multimedia/10xp-rapper/e0bfc2783d474396bd048d1eb92e2c89-mediumThreeByTwo440.jpg",
"format": "mediumThreeByTwo440",
"height": 293,
"width": 440,
"type": "image",
"subtype": "photo",
"caption": "Pras Michel, one of the founding members of the hip-hop group the Fugees, is charged with federal campaign finance violations.",
"copyright": "Slaven Vlasic/Getty Images"
}
]
}
]
}
""".data(using: .utf8)!

let TestURL = URL(string: "https://www.google.com/")!

let TestImage = UIImage.init(named: "image.jpg", in: Bundle.init(for: MockImageProvider.self), compatibleWith: nil)!
