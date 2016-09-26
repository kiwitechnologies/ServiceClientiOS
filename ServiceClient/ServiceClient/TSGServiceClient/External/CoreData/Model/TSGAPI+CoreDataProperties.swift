//
//  API+CoreDataProperties.swift
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

extension TSGAPI {

    @NSManaged var dev_baseURL: String?
    @NSManaged var prod_baseURL: String?
    @NSManaged var qa_baseURL: String?
    @NSManaged var stage_baseURL: String?
    @NSManaged var dummy_server_URL: String?
    @NSManaged var actionType: NSNumber?
    @NSManaged var actionName: String?
    @NSManaged var actionID: String?
    @NSManaged var params_parameters: NSNumber?
    @NSManaged var project: TSGProject?
    @NSManaged var parameters: NSSet?
    @NSManaged var headers: NSSet?
    @NSManaged var queryParameters: NSSet?

}
