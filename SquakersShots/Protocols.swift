//
//  Protocols.swift
//  SquakersShots
//
//  Created by Michal Pyrka on 20/05/2017.
//  Copyright © 2017 Michal Pyrka. All rights reserved.
//

import Foundation
import CoreData
import RealmSwift

protocol Encoded {
    associatedtype Encoder: NSCoding
    
    var encoder: Encoder { get }
}

protocol StructRepresentable {
    associatedtype StructType
    
    var `struct`: StructType { get }
}

protocol CoreDataRepresentable {
    associatedtype Value: NSManagedObject
    var managedObject: Value { get }
}

protocol RealmRepresentable {
    associatedtype Value: RealmSwift.Object
    var realmObject: Value { get }
}
