//
//  TSGValidationHelper.swift
//  ServiceSample
//
//  Created by Yogesh Bhatt on 27/05/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation

public class TSGValidationHelper: NSObject {
    
    class func checkIfItsRequired(obj:Key){
        requiredKeys?.addObject(obj.keyName!)
    }

    class func checkMinimumLenghth(obj:Key,dataType:DataType, withUserDict dict:NSDictionary,queryDict:NSDictionary?=nil, parameterType:ParameterType) {
        
        let minimumValue = obj.minimumLength
        let maximumValue = obj.maximumLength
        
        switch dataType {
        case .INTEGER:
            
            if let length = minimumValue  {
              
                switch parameterType {
                case .BODY_PARAMETER:
                    let userDataLength = dict.valueForKey(obj.keyName! as String) as? Int
                    
                    if userDataLength != nil {
                        if (userDataLength <= length as Int && (minimumValue != 0 && maximumValue != 0)){
                            errorMessage = "Length is not correct. It should be between \(obj.minimumLength) - \(obj.maximumLength)"
                            TSGValidationManager.sharedInstance.tsgErrorManger!.parameter.invalidErrorMessages(obj.keyName!, errorMsg: errorMessage)
                            TSGValidationManager.sharedInstance.validationPassed = false
                            
                        }
                        
                    }
                case .QUERY_PARAMETER:
                    
                    let userDataLength = dict.valueForKey(obj.keyName! as String) as? Int
                    
                    if userDataLength != nil {
                        if (userDataLength <= length as Int && (minimumValue != 0 && maximumValue != 0)){
                            errorMessage = "Length is not correct. It should be between \(obj.minimumLength) - \(obj.maximumLength)"
                            TSGValidationManager.sharedInstance.tsgErrorManger!.queryParameter.invalidErrorMessages(obj.keyName!, errorMsg: errorMessage)
                            TSGValidationManager.sharedInstance.validationPassed = false
                            
                        }
                        
                    }
                }

            }
            
            break
            
        case .FLOAT:
            
            if let length = minimumValue {
                
                switch parameterType {
                    
                case .BODY_PARAMETER:
                    let userDataLength = dict.valueForKey(obj.keyName! as String) as? Float
                    
                    if userDataLength != nil {
                        if (userDataLength <= length as Float && (minimumValue != 0 && maximumValue != 0)){
                            errorMessage = "Length is not correct. It should be between \(obj.minimumLength) - \(obj.maximumLength)"
                            TSGValidationManager.sharedInstance.tsgErrorManger!.parameter.invalidErrorMessages(obj.keyName!, errorMsg: errorMessage)
                            TSGValidationManager.sharedInstance.validationPassed = false
                            
                        }
                    }
                case .QUERY_PARAMETER:
                    
                    let userDataLength = dict.valueForKey(obj.keyName! as String) as? Float
                    
                    if userDataLength != nil {
                        if (userDataLength <= length as Float && (minimumValue != 0 && maximumValue != 0)){
                            errorMessage = "Length is not correct. It should be between \(obj.minimumLength) - \(obj.maximumLength)"
                            TSGValidationManager.sharedInstance.tsgErrorManger!.queryParameter.invalidErrorMessages(obj.keyName!, errorMsg: errorMessage)
                            TSGValidationManager.sharedInstance.validationPassed = false
                            
                        }
                    }
                }
 
            }
            
            break
            
        case .STRING:
            
            if let length = minimumValue  {
                switch parameterType {
                    
                case .BODY_PARAMETER:
                    let userDataLength = dict.valueForKey(obj.keyName! as String) as! String
                    
                    if (userDataLength.characters.count <= length as Int && (minimumValue != 0 && maximumValue != 0)){
                        errorMessage = "Length is not correct. It should be between \(obj.minimumLength) - \(obj.maximumLength)"
                        TSGValidationManager.sharedInstance.tsgErrorManger!.parameter.invalidErrorMessages(obj.keyName!, errorMsg: errorMessage)
                        
                        TSGValidationManager.sharedInstance.validationPassed = false
                        
                    }
                    
                    break
                    
                case .QUERY_PARAMETER:
                    
                    let userDataLength = queryDict!.valueForKey(obj.keyName! as String) as! String
                    
                    if (userDataLength.characters.count <= length as Int && (minimumValue != 0 && maximumValue != 0)){
                        errorMessage = "Length is not correct. It should be between \(obj.minimumLength) - \(obj.maximumLength)"
                        TSGValidationManager.sharedInstance.tsgErrorManger!.queryParameter.invalidErrorMessages(obj.keyName!, errorMsg: errorMessage)
                        TSGValidationManager.sharedInstance.validationPassed = false
                        
                    }
 
            }

                break
            }
            
        default:
            break
        }
    }
    
    class func checkMaximumLenght(obj:Key,dataType:DataType, withUserDict dict:NSDictionary, parameterType:ParameterType){
        
        let minimumValue = obj.minimumLength
        let maximumValue = obj.maximumLength
        
        switch dataType {
        case .INTEGER:
            
            switch parameterType {
            case .BODY_PARAMETER:
                
                let length = maximumValue as! Int
                let userDataLength = dict.valueForKey(obj.keyName! as String) as? Int
                
                if userDataLength != nil {
                    if (userDataLength > length && (minimumValue != 0 && maximumValue != 0)){
                        errorMessage = "Length is not correct. It should be between \(obj.minimumLength) - \(obj.maximumLength)"
                        TSGValidationManager.sharedInstance.tsgErrorManger!.parameter.invalidErrorMessages(obj.keyName!, errorMsg: errorMessage)
                        TSGValidationManager.sharedInstance.validationPassed = false
                        
                    }
                    
                }

            case .QUERY_PARAMETER:
                let length = maximumValue as! Int
                let userDataLength = dict.valueForKey(obj.keyName! as String) as? Int
                
                if userDataLength != nil {
                    if (userDataLength > length && (minimumValue != 0 && maximumValue != 0)){
                        errorMessage = "Length is not correct. It should be between \(obj.minimumLength) - \(obj.maximumLength)"
                        TSGValidationManager.sharedInstance.tsgErrorManger!.queryParameter.invalidErrorMessages(obj.keyName!, errorMsg: errorMessage)
                        TSGValidationManager.sharedInstance.validationPassed = false
                    }
                }
            }
            
            break
            
        case .FLOAT:
            
            switch parameterType {
            case .BODY_PARAMETER:
                let length = maximumValue as! Float
                let userDataLength = dict.valueForKey(obj.keyName! as String) as? Float
                
                if userDataLength != nil {
                    if (userDataLength > length && (minimumValue != 0 && maximumValue != 0)){
                        errorMessage = "Length is not correct. It should be between \(obj.minimumLength) - \(obj.maximumLength)"
                        TSGValidationManager.sharedInstance.tsgErrorManger!.parameter.invalidErrorMessages(obj.keyName!, errorMsg: errorMessage)
                        TSGValidationManager.sharedInstance.validationPassed = false
                        
                    }
                }

            case .QUERY_PARAMETER:
                let length = maximumValue as! Float
                let userDataLength = dict.valueForKey(obj.keyName! as String) as? Float
                
                if userDataLength != nil {
                    if (userDataLength > length && (minimumValue != 0 && maximumValue != 0)){
                        errorMessage = "Length is not correct. It should be between \(obj.minimumLength) - \(obj.maximumLength)"
                        TSGValidationManager.sharedInstance.tsgErrorManger!.queryParameter.invalidErrorMessages(obj.keyName!, errorMsg: errorMessage)
                        TSGValidationManager.sharedInstance.validationPassed = false
                        
                    }
                }
            }
            
            break
        case .STRING:
            let length = maximumValue as! Int
            let userDataLength = dict.valueForKey(obj.keyName! as String) as! String
            
            if (userDataLength.characters.count > length && (minimumValue != 0 && maximumValue != 0)){
                errorMessage = "Length is not correct. It should be between \(obj.minimumLength) - \(obj.maximumLength)"
                
                if parameterType == ParameterType.BODY_PARAMETER {
                    TSGValidationManager.sharedInstance.tsgErrorManger!.parameter.invalidErrorMessages(obj.keyName!,errorMsg: errorMessage)

                }else {
                    TSGValidationManager.sharedInstance.tsgErrorManger!.queryParameter.invalidErrorMessages(obj.keyName!,errorMsg: errorMessage)

                }
                TSGValidationManager.sharedInstance.validationPassed = false
                
            }
        default:
            break
        }
        
    }

  class func checkFileSize(obj:Key, withData data:NSData?=nil) {
        
        if data == nil {return}
        if data!.length > obj.size?.integerValue || data!.length  < 0 {
            errorMessage = "\n Size of file is not in range of 1 - \(obj.size)"
            fileSizeKey?.addObject(obj.keyName!)
        }
        
    }
    
   class func checkFormats(obj:Key, withUserDict dict:NSDictionary) {
    

        switch dict.valueForKey(obj.keyName! as String) {
        case is String:
            let strValue = dict.valueForKey(obj.keyName! as String) as! String
            
            switch obj.format as! Int {
                
            case StingFormatType.ALPHA.hashValue:
                alphaKey?.addObject(obj.keyName!)
                
                break
                
            case StingFormatType.ALPHANUMERIC.hashValue:
                break
                
            case StingFormatType.EMAIL.hashValue:
                let isEmail:Bool = strValue.isEmail
                
                if !isEmail {
                    errorMessage = "Email format is wrong"
                    emailKeys?.addObject(obj.keyName!)
                    TSGValidationManager.sharedInstance.tsgErrorManger!.parameter.invalidErrorMessages(obj.keyName!, errorMsg: errorMessage)
                    TSGValidationManager.sharedInstance.validationPassed = false
                }
                break
                
            case StingFormatType.NUMERIC.hashValue:
                numericKeys?.addObject(obj.keyName!)
                break
                
            default:
                
                break
            }
            break
        case is NSData:
            TSGValidationHelper.checkFileSize(obj, withData: dict.valueForKey(obj.keyName! as String) as? NSData)
            break
        default:
            break
        }
    }
    

}