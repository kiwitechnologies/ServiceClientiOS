//
//  Key+CoreDataProperties.swift
//  ServiceClient
//
//  Created by Ayush on 4/21/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Key {

    @NSManaged var format: NSNumber?
    @NSManaged var minimumLength: NSNumber?
    @NSManaged var maximumLength: NSNumber?
    @NSManaged var size: NSNumber?
    @NSManaged var dataType: NSNumber? //eg. Int,Float,String
    @NSManaged var required: NSNumber?
    @NSManaged var keyName: String?
    @NSManaged var keyValues: String?
    @NSManaged var parameterAPI: API?
    @NSManaged var headerAPI: API?
    @NSManaged var queriesAPI: API?

}
