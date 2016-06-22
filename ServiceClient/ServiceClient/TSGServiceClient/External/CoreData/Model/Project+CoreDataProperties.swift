//
//  Project+CoreDataProperties.swift
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

extension Project {

    @NSManaged var projectID: String?
    @NSManaged var lastmodifiedDate: NSDate?
    @NSManaged var requiredAPI: NSSet?
    @NSManaged var versionNumber: String?
    @NSManaged var apiVersion: String?

}
