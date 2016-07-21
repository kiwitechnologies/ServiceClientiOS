//
//  Project.swift
//  ServiceClient
//
//  Created by Ayush on 4/21/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation
import CoreData


public class Project: NSManagedObject {
    
    
    public class func saveProjectInfo(dictionary:NSMutableDictionary){
        
        //let projectID = dictionary.valueForKey("project_id")
        
        let unixTime = dictionary.valueForKey("updated_at")
        
        var projectID :String! {
            willSet {
                if checkIfProjectIdExist(dictionary.valueForKey("project_id") as! String) {
                  deleteProject()
                }
            }
        }
        projectID = dictionary.valueForKey("project_id") as! String
        
        NSUserDefaults().setObject(projectID, forKey: "ProjectID")
        
        let date = NSDate(timeIntervalSince1970: (unixTime as! NSTimeInterval)/1000)
        
        let context = TSGServiceClientCoreDataHelper.privateMoc()
        
        context.performBlockAndWait
            {
                let entity =  NSEntityDescription.entityForName("Project",
                    inManagedObjectContext:context)
                
                let projectObj:Project = NSManagedObject(entity: entity!,
                    insertIntoManagedObjectContext: context) as! Project
                
                projectObj.projectID = projectID
                projectObj.lastmodifiedDate = date

                projectObj.versionNumber = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as? String
                
                let apiVersion:Float = dictionary.valueForKey("version_no") as! Float
                projectObj.apiVersion = apiVersion.description
                
                projectObj.setValue(API.allProjectAPI(dictionary.valueForKey("actions")!, context: context), forKey: "requiredAPI")
                
                do {
                    try context.save()
                    TSGServiceClientCoreDataHelper.saveDataContext()
                    
                } catch let error as NSError  {
                     print("Could not save \(error), \(error.userInfo)")
                }
        }
    }
    
    class func checkIfProjectIdExist(actionName:String)->Bool{
            
            let context = TSGServiceClientCoreDataHelper.sharedInstance().mainMOC
            var objects: [Project]!
            
            context.performBlockAndWait {
                //2
                do {
                    let fetchRequest = NSFetchRequest(entityName: "Project")
                    fetchRequest.predicate = NSPredicate(format: "projectID = %@", actionName)
                    fetchRequest.fetchLimit = 1
                    try objects = context.executeFetchRequest(fetchRequest) as? [Project]

                    if objects.count > 0 {
                        _ = objects[0]
                    }
                    
                } catch {
                    
                    print("No Objects \(objects)")
                }
            }
            
            if objects.count == 0 {
                return false
            }
            
            return true
    }
 
    class func deleteProject(){
        
        let context = TSGServiceClientCoreDataHelper.sharedInstance().mainMOC

        let fetchRequest = NSFetchRequest(entityName: "Project")
        if #available(iOS 9.0, *) {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try context.executeRequest(deleteRequest)
            } catch let error as NSError {
                debugPrint(error)
            }
        } else {
            // Fallback on earlier versions
            let context = TSGServiceClientCoreDataHelper.sharedInstance().mainMOC

            let fetchRequest = NSFetchRequest(entityName: "Project")
            fetchRequest.returnsObjectsAsFaults = false
            
            do
            {
                let results = try context.executeFetchRequest(fetchRequest)
                for managedObject in results
                {
                    let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                    context.deleteObject(managedObjectData)
                }
            } catch let error as NSError {
                print(error)
            }
        }
        

    }
    
    class func getProjectDetail(projectID:String?)->AnyObject!{
        
        let context = TSGServiceClientCoreDataHelper.sharedInstance().mainMOC
        var objects: [Project]!
        
        if projectID == nil {return nil}
        context.performBlockAndWait {
            //2
            do {
                let fetchRequest = NSFetchRequest(entityName: "Project")
                fetchRequest.predicate = NSPredicate(format: "projectID = %@", projectID!)
                fetchRequest.fetchLimit = 1
                try objects = context.executeFetchRequest(fetchRequest) as? [Project]
                
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



