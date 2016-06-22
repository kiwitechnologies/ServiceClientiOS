//
//  TSGValidationErrors.swift
//  ServiceSample
//
//  Created by Yogesh Bhatt on 13/05/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation

public class TSGErrorValuesHolder:JSONModel{
    
    var missingKey:NSMutableDictionary = [:]
    var invalidKey:NSMutableDictionary = [:]
    
    internal func missingErrorMessages(keyName:String, errorMsg:String){
        
        if (missingKey.valueForKey(keyName) == nil) {
            let invalidArray:NSMutableArray = []
            invalidArray.addObject(errorMsg)
            missingKey.setValue(invalidArray, forKey: keyName)
            
        } else {
            let invalidArray = missingKey.valueForKey(keyName)
            invalidArray!.addObject(errorMsg)
            missingKey.setValue(invalidArray, forKey: keyName)
            
        }
        
    }
    
    internal func invalidErrorMessages(keyName:String, errorMsg:String){
        
        if (invalidKey.valueForKey(keyName) == nil) {
            let invalidArray:NSMutableArray = []
            invalidArray.addObject(errorMsg)
            invalidKey.setValue(invalidArray, forKey: keyName)
            
            
        } else {
            let invalidArray = invalidKey.valueForKey(keyName)
            invalidArray!.addObject(errorMsg)
            invalidKey.setValue(invalidArray, forKey: keyName)
        }

    }
    
}