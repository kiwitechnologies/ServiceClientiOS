//
//  TSGErrorManager.swift
//  ServiceSample
//
//  Created by Yogesh Bhatt on 16/05/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation


public class TSGErrorManager:JSONModel {
    
    var parameter:TSGErrorValuesHolder = TSGErrorValuesHolder()
    var header:TSGErrorValuesHolder = TSGErrorValuesHolder()
    var queryParameter:TSGErrorValuesHolder = TSGErrorValuesHolder()
    var pathParameter:TSGErrorValuesHolder = TSGErrorValuesHolder()
    
    var missingAction:NSMutableDictionary = [:]

    internal func missingactionKeyMessages(keyName:String, errorMsg:String){
        
        
        if (missingAction.valueForKey(keyName) == nil) {
            let invalidArray:NSMutableArray = []
            invalidArray.addObject(errorMessage)
            missingAction.setValue(invalidArray, forKey: keyName)
            
        } else {
            let invalidArray = missingAction.valueForKey(keyName)
            invalidArray!.addObject(errorMessage)
            missingAction.setValue(invalidArray, forKey: keyName)
        }
        
    }
    
    internal func mystring() -> String
    {
        if let mydict = self.toJSONString() {
            missingAction.removeAllObjects()
            
            return mydict
        }
        
       return "Error in converting to JSONString"
    }
    
}