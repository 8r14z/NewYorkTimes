//
//  CDArticle+CoreDataProperties.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//
//

import Foundation
import CoreData



extension CDArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDArticle> {
        return NSFetchRequest<CDArticle>(entityName: "CDArticle")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var imageURL: String?
    @NSManaged public var snippet: String?
    @NSManaged public var title: String?

}
