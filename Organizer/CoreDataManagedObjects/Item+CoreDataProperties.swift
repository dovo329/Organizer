//
//  Item+CoreDataProperties.swift
//  Organizer
//
//  Created by Douglas Voss on 2/3/18.
//  Copyright © 2018 VossWareLLC. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var category: Category?

}
