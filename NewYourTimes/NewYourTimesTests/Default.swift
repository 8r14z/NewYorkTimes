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


enum TestAPI {
    case article
    case search
}


let TestError = NetworkError.unexpected

let TestURL = URL(string: "https://www.google.com/")!

let TestImage = UIImage.init(named: "image.jpg", in: Bundle.init(for: MockServiceProvider.self), compatibleWith: nil)!

let TestArticle = Article(title: "Title",
                          snippet: "Snippet",
                          updatedDate: Date(),
                          publishedDate: Date(),
                          images: [
                            Image(url: "url", format: .mediumThreeByTwo440, caption: "Caption", width: 200, height: 200)
    ],
                          author: "Author",
                          publisher: "Publisher")

// MARK: JSON Object
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
    "updated_date": "2019-05-10T06:08:12-04:00",
    "published_date": "2019-05-09T20:00:00-04:00",
    "byline": "The New Your Times",
    "source": "The New York Times",
    "multimedia": [ImageJSON]
]

let ArticleResponse: JSON = [
    "results": [ArticleJSON]
]


// MARK: JSON Data
let ArticleRawJSON = """
 
        {
            "slug_name": "11El-Times-Border-Crossing",
            "section": "Universal",
            "subsection": "América",
            "title": "La espera en la frontera: ¿quiere su orden con papas fritas?",
            "abstract": "Esta semana: una noche en una hamburguesería a unos metros de la frontera y el complicado lenguaje de la frontera",
            "url": "https://www.nytimes.com/2019/05/10/universal/es/la-espera-en-la-frontera-quiere-su-orden-con-papas-fritas.html",
            "byline": "Por THE NEW YORK TIMES",
            "thumbnail_standard": "https://static01.nyt.com/images/2019/05/09/us/09bordernewsletter-01-copy-ES/09bordernewsletter-01-thumbStandard.jpg",
            "item_type": "Article",
            "source": "The New York Times",
            "updated_date": "2019-05-10T19:48:03-04:00",
            "created_date": "2019-05-10T19:48:03-04:00",
            "published_date": "2019-05-09T20:00:00-04:00",
            "first_published_date": "2019-05-10T19:46:33-04:00",
            "material_type_facet": "News",
            "kicker": "",
            "subheadline": null,
            "des_facet": "",
            "org_facet": "",
            "per_facet": "",
            "geo_facet": "",
            "related_urls": [
                {
                    "suggested_link_text": "Waiting at the Border: Do You Want Fries With That?",
                    "url": "https://www.nytimes.com/2019/05/09/us/border-language-immigration.html"
                }
            ],
            "multimedia": ""
        }
    
""".data(using: .utf8)!

let ImageRawJSON = """
{
                    "url": "https://static01.nyt.com/images/2019/05/10/opinion/10stephensSub/10stephensSub-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Members of MS-13, a gang that has taken over parts of San Pedro Sula, Honduras, and has a presence in the United States.",
                    "copyright": "Tyler Hicks/The New York Times"
                }
""".data(using: .utf8)!

let SearchArticleRawJSON = """
{
"web_url": "https://www.nytimes.com/2018/03/12/world/europe/slovakia-robert-kalinak-jan-kuciak.html",
"snippet": "The interior minister bowed to pressure to resign, and the governing party pledged a thorough investigation into the recent killing of a journalist.",
"lead_paragraph": "BRATISLAVA, Slovakia — Trying to maintain its grip on power, Slovakia’s governing party announced on Monday that the interior minister would step down, and pledged a thorough investigation into the killing of a young journalist who was investigating government corruption in the small Central European nation.",
"abstract": "The interior minister bowed to pressure to resign, and the governing party pledged a thorough investigation into the recent killing of a journalist.",
"print_page": "10",
"blog": {},
"source": "The New York Times",
"multimedia": null,
"headline": {
"main": "After Murder and Protests, Slovak Leaders Struggle to Keep Power",
"kicker": null,
"content_kicker": null,
"print_headline": "Slovak Leaders Struggle to Keep Power as Protests Grow After a Journalist’s Murder",
"name": null,
"seo": null,
"sub": null
},
"keywords": null,
"pub_date": "2018-03-12T13:30:16+0000",
"document_type": "article",
"news_desk": "Foreign",
"section_name": "World",
"subsection_name": "Europe",
"byline": {
"original": "By Miroslava Germanova and Marc Santora",
"person": null,
"organization": null
},
"type_of_material": "News",
"_id": "5c9e95ec49f0eacbf110a92c",
"word_count": 748,
"uri": "nyt://article/ff97b7cc-e9aa-51f5-8d01-ec0a6f5bb698"
}

""".data(using: .utf8)!
