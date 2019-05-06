//
//  Article+CoreDataProperties.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/4/19.
//  Copyright © 2019 An Le. All rights reserved.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var imageURL: String?
    @NSManaged public var snippet: String?
    @NSManaged public var title: String?

}
