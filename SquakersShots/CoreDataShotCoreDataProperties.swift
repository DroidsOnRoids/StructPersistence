//
//  CoreDataShot+CoreDataProperties.swift
//  SquakersShots
//
//  Created by Michal Pyrka on 18/05/2017.
//  Copyright © 2017 Michal Pyrka. All rights reserved.
//

import CoreData

extension CoreDataShot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataShot> {
        return NSFetchRequest<CoreDataShot>(entityName: "CoreDataShot")
    }

    @NSManaged public var id: Int64
    @NSManaged public var buckets: Int64
    @NSManaged public var comments: Int64
    @NSManaged public var likes: Int64
    @NSManaged public var url: String
    @NSManaged public var views: Int64

}
