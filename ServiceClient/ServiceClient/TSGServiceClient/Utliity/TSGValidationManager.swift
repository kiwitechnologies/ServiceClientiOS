//
//  ValidationManager.swift
//  ServiceSample
//
//  Created by Yogesh Bhatt on 28/04/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation

var errorMessage:String!

public class TSGValidationManager {

    
    var tsgErrorManger:TSGErrorManager? = TSGErrorManager()
    
    var validationPassed:Bool = true

    /*
     *Singleton method
     */
    public class var sharedInstance: TSGValidationManager {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: TSGValidationManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = TSGValidationManager()
        }
        return Static.instance!
    }

    public class func validateActionData(actionID:String,withQueryParma queryParamDict:NSDictionary?=nil, withBodyParam userBodyDict:NSDictionary?=nil, withHeaderDic userHeaderDic:NSDictionary?=nil, withOptionalData data:NSData?=nil, onSuccess success:(AnyObject,String)->(), onFailure failure:(NSError)->()){
        
        errorMessage = ""
        TSGValidationManager.sharedInstance.validationPassed = true
        
        if let apiObj =  API.getApiForAction(actionID) {
            var paramKeys:NSSet!
            var headerKeys:NSSet!
            var queryParamKeys:NSSet!

            switch apiObj {
                
            case is API:
                paramKeys = (apiObj as! API).parameters!
                headerKeys = (apiObj as! API).headers!
                queryParamKeys = (apiObj as! API).queryParameters
//                if (apiObj as! API).params_parameters == 1 {
//                    completeURL = TSGUtility.createPathParamURL(completeURL, pathParamDict: pathParamDict!)
//                }

                break
                
            default:
                errorMessage = "\(actionID) is not found"
                TSGValidationManager.sharedInstance.tsgErrorManger!.missingactionKeyMessages((apiObj as! API).actionName!, errorMsg:errorMessage)
                TSGValidationManager.sharedInstance.validationPassed = false
                
            }
            
            if let allUserKeys = userBodyDict?.allKeys {
                
                for item in paramKeys! {
                    
                    let keyProperty = item as! Key
                    
                    let isRequired = keyProperty.required
                    var isFoundRequiredKey:Bool = false
                    
                    for key in allUserKeys {
                        let apiParams = item as! Key
                        
                        if apiParams.keyName == key as? String {
                            isFoundRequiredKey = true
                            let dataType = apiParams.dataType as! Int
                            
                            TSGValidationManager.sharedInstance.requiredValidation(dataType, apiParams: apiParams, dict: userBodyDict!, parameterType: ParameterType.BODY_PARAMETER)
                            
                        }
                    }
                    if !isFoundRequiredKey && isRequired == 1{
                        TSGValidationManager.sharedInstance.tsgErrorManger!.parameter.missingErrorMessages(keyProperty.keyName!, errorMsg: "Required key is missing")
                        isFoundRequiredKey = false
                        TSGValidationManager.sharedInstance.validationPassed = false
                    }
                }
                
            }
            
            if let allUserQueryKeys = (queryParamDict?.allKeys) {
                
                for item in queryParamKeys! {
                    
                    let keyProperty = item as! Key
                    
                    let isRequired = keyProperty.required
                    var isFoundRequiredKey:Bool = false
                    
                    for key in allUserQueryKeys {
                        let apiParams = item as! Key
                        
                        if apiParams.keyName == key as? String {
                            isFoundRequiredKey = true
                            let dataType = apiParams.dataType as! Int
                            
                            TSGValidationManager.sharedInstance.requiredValidation(dataType, apiParams: apiParams, dict: queryParamDict!,parameterType: ParameterType.QUERY_PARAMETER)
                        }
                    }
                    
                    if !isFoundRequiredKey && isRequired == 1{
                        TSGValidationManager.sharedInstance.tsgErrorManger!.queryParameter.missingErrorMessages(keyProperty.keyName!, errorMsg: "Required key is missing")
                        isFoundRequiredKey = false
                        TSGValidationManager.sharedInstance.validationPassed = false
                    }
                }
            }
            
            TSGValidationManager.sharedInstance.checkHeaderValidation(headerKeys, headerDict: userHeaderDic)
            
            if TSGValidationManager.sharedInstance.validationPassed {
                success(apiObj,"pass")
            }
        }
        else {
            errorMessage = "\(actionID) is not found"
            TSGValidationManager.sharedInstance.tsgErrorManger!.missingactionKeyMessages(actionID, errorMsg:errorMessage)
            TSGValidationManager.sharedInstance.validationPassed = false
        }
            
            if !TSGValidationManager.sharedInstance.validationPassed  {
                let str:String = TSGValidationManager.sharedInstance.tsgErrorManger!.mystring()
                
                if TSGValidationManager.sharedInstance.tsgErrorManger != nil {
                    TSGValidationManager.sharedInstance.tsgErrorManger = nil
                    TSGValidationManager.sharedInstance.tsgErrorManger = TSGErrorManager()
                }
                
                if let data = str.dataUsingEncoding(NSUTF8StringEncoding) {
                    do {
                        let temp:[String:AnyObject] = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String : AnyObject]
                        failure(NSError(domain: "Failed", code: 1004, userInfo:[NSLocalizedDescriptionKey : temp]))
                        
                    } catch _ {
                    }
                }
            }
    }
    
    
    func  checkHeaderValidation(headers:NSSet!, headerDict:NSDictionary!) -> Void {
        
        for key in headers {
            
            let apiParams = key as! Key
            
            if headerDict?.valueForKey(apiParams.keyName!) == nil {
                
                errorMessage = "Required key is missing in Header"
                TSGValidationManager.sharedInstance.tsgErrorManger!.header.missingErrorMessages(apiParams.keyName!, errorMsg: errorMessage)
                
            }
            if let allHeaderKeys = headerDict?.allKeys {
                
                for item in allHeaderKeys {
                    let headerParams = item as! String
                    
                    if apiParams.keyName == headerParams {
                        
                        let keyValue:String = headerDict.valueForKey(apiParams.keyName!) as! String
                        
                        if (apiParams.keyValues?.characters.count>1 && keyValue.characters.count < 1)  {
                            errorMessage = "Required key is missing in Header"
                            TSGValidationManager.sharedInstance.tsgErrorManger!.header.missingErrorMessages(apiParams.keyName!, errorMsg: errorMessage)

                            TSGValidationManager.sharedInstance.validationPassed = false
                        }
                    }
                }
            }
        }
    }
    
    func requiredValidation(dataType:Int, apiParams:Key,dict:NSDictionary,queryDict:NSDictionary?=nil, withData data:NSData?=nil, parameterType:ParameterType) -> Void {
        
        switch dataType {
        case DataType.FILE.hashValue:
        
            TSGValidationHelper.checkFileSize(apiParams,withData:data)
            TSGValidationHelper.checkFormats(apiParams, withUserDict: dict)
            TSGValidationHelper.checkIfItsRequired(apiParams)
            TSGValidationHelper.checkMinimumLenghth(apiParams, dataType: DataType.FILE, withUserDict: dict, queryDict: queryDict, parameterType: parameterType)
            TSGValidationHelper.checkMaximumLenght(apiParams,dataType: DataType.FILE, withUserDict: dict, parameterType:parameterType)
            break
            
        case DataType.FLOAT.hashValue:
            TSGValidationHelper.checkMaximumLenght(apiParams,dataType: DataType.FLOAT, withUserDict: dict, parameterType:parameterType)
            TSGValidationHelper.checkMinimumLenghth(apiParams, dataType: DataType.FILE, withUserDict: dict, queryDict: queryDict, parameterType: parameterType)
            TSGValidationHelper.checkIfItsRequired(apiParams)
            break
            
        case DataType.INTEGER.hashValue:
            TSGValidationHelper.checkMaximumLenght(apiParams,dataType: DataType.FLOAT, withUserDict: dict, parameterType:parameterType)
            TSGValidationHelper.checkIfItsRequired(apiParams)
            TSGValidationHelper.checkMinimumLenghth(apiParams, dataType: DataType.FILE, withUserDict: dict, queryDict: queryDict, parameterType: parameterType)
            break
            
        case DataType.STRING.hashValue:
            TSGValidationHelper.checkMaximumLenght(apiParams,dataType: DataType.FLOAT, withUserDict: dict, parameterType:parameterType)
            TSGValidationHelper.checkMinimumLenghth(apiParams, dataType: DataType.FILE, withUserDict: dict, queryDict: queryDict, parameterType: parameterType)
            TSGValidationHelper.checkFormats(apiParams, withUserDict: dict)
            TSGValidationHelper.checkIfItsRequired(apiParams)
            break
            
        case DataType.TEXT.hashValue:
            TSGValidationHelper.checkMaximumLenght(apiParams,dataType: DataType.FLOAT, withUserDict: dict, parameterType:parameterType)
            TSGValidationHelper.checkMinimumLenghth(apiParams, dataType: DataType.FILE, withUserDict: dict, queryDict: queryDict, parameterType: parameterType)
            TSGValidationHelper.checkIfItsRequired(apiParams)
            break
            
        default:
            break
            
        }
    }
}
