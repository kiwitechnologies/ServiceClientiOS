//
//  API.swift
//  ServiceClient
//
//  Created by Ayush on 4/21/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation
import CoreData


public class TSGAPI: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    class func allProjectAPI(dictArray:AnyObject, context:NSManagedObjectContext) -> NSSet{
    
        let APISet:NSMutableSet = NSMutableSet()
        for api in (dictArray as? NSMutableArray)! {
            
            let actionName = api.valueForKey("action")
            let actionID = api.valueForKey("action_id")
            let requestType = api.valueForKey("request_type") as! String
            
            let apiEntity = NSEntityDescription.entityForName("TSGAPI",
                                                              inManagedObjectContext: context)
            
            let apiObj:TSGAPI = NSManagedObject(entity: apiEntity!, insertIntoManagedObjectContext: context) as! TSGAPI
            
            for category in RequestType.allValues{
                if requestType.caseInsensitiveCompare(category.rawValue) == NSComparisonResult.OrderedSame{
                    apiObj.actionType = category.hashValue
                }
            }
            
            apiObj.actionName = actionName as? String
            apiObj.actionID = actionID as? String
            apiObj.dummy_server_URL = api.valueForKey("dummy_server_url") as? String
            apiObj.dev_baseURL = api.valueForKey("dev_url") as? String
            apiObj.qa_baseURL = api.valueForKey("qa_url") as? String
            apiObj.stage_baseURL = api.valueForKey("staging_url") as? String
            apiObj.prod_baseURL = api.valueForKey("production_url") as? String

            let headerDictionary = api.valueForKey("headers")
            let bodyDicitionary = api.valueForKey("body_parameters")
            let queryDictionary = api.valueForKey("query_parameters")
            let requiredKey:Int = api.valueForKey("params_parameters") as! Int
            
            apiObj.params_parameters = NSNumber(integer: requiredKey)

            apiObj.headers = TSGKey.allHeaders(headerDictionary, context: context)
            apiObj.parameters = TSGKey.allParameters(bodyDicitionary, context: context)
            
            apiObj.queryParameters = TSGKey.allQueryParams(queryDictionary,context:context)
            
            APISet.addObject(apiObj)
        }
        
        return APISet
    }
    
    class func getApiForAction(actionID:String)->AnyObject!{
        
        let context = TSGServiceClientCoreDataHelper.sharedInstance().mainMOC
        var objects: [TSGAPI]!

        context.performBlockAndWait {
            //2
            do {
                let fetchRequest = NSFetchRequest(entityName: "TSGAPI")
                fetchRequest.predicate = NSPredicate(format: "actionID = %@", actionID)
                fetchRequest.fetchLimit = 1
                try objects = context.executeFetchRequest(fetchRequest) as? [TSGAPI]
                
            } catch {
                
                print("No Objects \(objects)")
            }
        }
        
        if objects.count == 0 {
            return nil
        }

        return objects[0]
    }
}
