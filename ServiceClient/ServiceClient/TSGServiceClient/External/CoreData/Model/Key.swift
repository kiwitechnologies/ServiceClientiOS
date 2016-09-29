//
//  Key.swift
//  ServiceClient
//
//  Created by Ayush on 4/21/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation
import CoreData


class Key: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    class func allParameters( arrayDict:AnyObject!, context:NSManagedObjectContext) -> NSSet{
    
        let APISet:NSMutableSet = NSMutableSet()

        let keyEntity = NSEntityDescription.entityForName("Key",
                                                          inManagedObjectContext: context)

        for object in arrayDict as! NSMutableArray {
            
            let keyObj:Key = NSManagedObject(entity: keyEntity!, insertIntoManagedObjectContext: context) as! Key
            let keyName = object.valueForKey("key_name")
            let validationData = object.valueForKey("validation_data_type")
            let validations:NSDictionary = object.valueForKey("validations") as! NSDictionary
            
            let formatType = validations.valueForKey("format_string")
            
            keyObj.keyName = keyName as? String
            keyObj.dataType = NSNumber(integer: validationData as! Int)
            keyObj.format =  NSNumber(integer: formatType as! Int)
            
            if let sizeValue:Int = validations.valueForKey("size") as? Int {
                if sizeValue > 0 {
                    keyObj.size = NSNumber(integer: sizeValue)
                }
            }

            if validations.valueForKey("min") != nil && !((validations.valueForKey("min") as! String).isEmpty){
                let minimumlength = validations.valueForKey("min") as! String
                keyObj.minimumLength =   NSNumber(integer: Int(minimumlength)!)

            }
            
            if validations.valueForKey("max") != nil && !((validations.valueForKey("max") as! String).isEmpty){
                let minimumlength = validations.valueForKey("max") as! String
                keyObj.maximumLength =   NSNumber(integer: Int(minimumlength)!)
                
            }
            
            let requiredKey:Int = validations.valueForKey("require") as! Int

            keyObj.required = NSNumber(integer: requiredKey)
          APISet.addObject(keyObj)

        }
        
        return APISet
    }
    
    class func allQueryParams( arrQueryParams:AnyObject!, context:NSManagedObjectContext) -> NSSet{
        
        let APISet:NSMutableSet = NSMutableSet()
        
        let keyEntity = NSEntityDescription.entityForName("Key",
                                                          inManagedObjectContext: context)
        
        for  object in arrQueryParams as! NSMutableArray {
            
            let keyObj:Key = NSManagedObject(entity: keyEntity!, insertIntoManagedObjectContext: context) as! Key
            let keyName = object.valueForKey("key_name")
            let validationData = object.valueForKey("validation_data_type")
            let validations:NSDictionary = object.valueForKey("validations") as! NSDictionary
            
            let formatType = validations.valueForKey("format_string")
            
            keyObj.keyName = keyName as? String
            keyObj.dataType = NSNumber(integer: validationData as! Int)
            keyObj.format =  NSNumber(integer: formatType as! Int)
            
            if let sizeValue:Int = validations.valueForKey("size") as? Int {
                if sizeValue > 0 {
                    keyObj.size = NSNumber(integer: sizeValue)
                }
            }
            
            if validations.valueForKey("min") != nil && !((validations.valueForKey("min") as! String).isEmpty){
                let minimumlength = validations.valueForKey("min") as! String
                keyObj.minimumLength =   NSNumber(integer: Int(minimumlength)!)
                
            }
            
            if validations.valueForKey("max") != nil && !((validations.valueForKey("max") as! String).isEmpty){
                let minimumlength = validations.valueForKey("max") as! String
                keyObj.maximumLength =   NSNumber(integer: Int(minimumlength)!)
                
            }
            
            let requiredKey:Int = validations.valueForKey("require") as! Int
            
            keyObj.required = NSNumber(integer: requiredKey)
            APISet.addObject(keyObj)

            
        }
        return APISet
        
    }
 
    
    class func allHeaders( arrHeaders:AnyObject!, context:NSManagedObjectContext) -> NSSet{
    
        
        let APISet:NSMutableSet = NSMutableSet()
        
        let keyEntity = NSEntityDescription.entityForName("Key",
                                                          inManagedObjectContext: context)

        for  object in arrHeaders as! NSMutableArray {
            
            let keyObj:Key = NSManagedObject(entity: keyEntity!, insertIntoManagedObjectContext: context) as! Key
            
            let keyName = object.valueForKey("key_name")

            if let keyValue = object.valueForKey("key_value") {
                
                let stringRepresentation = keyValue.componentsJoinedByString(",")
                keyObj.keyValues = stringRepresentation
 
            }
            keyObj.keyName = keyName as? String
            

            APISet.addObject(keyObj)
            
        }
        return APISet
    }
    
}
