//
//  TSGServiceManager.swift
//  ServiceClient
//
//  Created by Yogesh Bhatt on 21/04/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation
import CoreData

public class TSGServiceManager {
    
    /**
     *	@functionName	: setProjectRuningMode
     *	@parameters		: releaseMode : It would be a unique identifier of each Project
     *	@description	: It would be used to set projectID in app
     */
    
    public class func setProjectRuningMode( releaseMode:AppRuningModeType) {
        
        TSGHelper.setProjectRuningMode(releaseMode)
    }
    
    /**
     *	@functionName	: setHeader
     *	@parameters		: someDict : It would be dictionary of required set of Headers
     *	@description	: Call services for device reg and google analytics
     */
    
    public class func setHeader(someDict:[NSObject:AnyObject]) {
        
       TSGHelper.setCustomHeader(someDict)
    }
    
    public class func setContentType(contentType:String) {
        
       // print(contentType)
        TSGHelper.sharedInstance.setContentType = contentType
    }
    /**
     *	@functionName           : removeHeader
     *	@completion Block		: deviceTokeString : It would be a unique identifier of device
     *	@description            : It would be used to remove Headers
     */
    
    public class func removeHeader() {
        TSGHelper.removeCustomHeader()

    }
    
    /**
     *	@functionName	: performAction
     *	@parameters		: actionID : It would be ID of api which we request to get response
                        : dict : It would be a required dictionary to pass to api
     *	@return			:
     *	@description	: It would be used to make request for any(REST api) and to recieve response
     */
    

    public class func performAction(actionID:String,withQueryParam queryParamDict:[String:String]?=nil, withParams dict:[String:String]?=nil, withTag apiTag:String?=nil, onSuccess success:(AnyObject)->(), onFailure failed:(Bool, NSError)->()){

        TSGHelper.requestedApi(actionID,withQueryParam: queryParamDict, withParam: dict, withTag:apiTag,  onSuccess: { (dictionary) in
            success(dictionary)
            }) { (bool, error) in
            failed(bool,error)
        }
    }

    /**
     *	@functionName	: request
     *	@description	: It would be used to make request
     */
    
    public class func request(requestType:HttpRequestType){
        
    }
    
    /**
     *	@functionName	: cancelAllRequest
     *	@description	: It would be used to cancel request
     */
    
    public class func cancelAllRequest(completion:(Bool)->()) {
        TSGHelper.cancelAllRequests()
    }
    
    
    /**
     *	@functionName	: cancelRequestWithActionID
     *	@description	: It would be used to cancel request
     */
    
    public class func cancelRequestWithTagId(tagID:String)->() {
        TSGHelper.cancelRequestWithTag(tagID)
    }
    /**
     *	@functionName	: uploadData
     *	@parameters		: imageData : It would be a unique identifier of device
     *	@description	: It would be used to upload the data
     */
    
    public class func uploadData(actionName:String, mimeType:MimeType,queryParam:NSDictionary?=nil,bodyParams:NSDictionary,dataKeyName:String,imageQuality:ImageQuality, progress: (percentage: Float) -> Void, success:(response:AnyObject) -> Void, failure:ErrorType->Void) {
        
      
        TSGHelper.uploadFile(actionName, bodyParams: bodyParams,dataKeyName:dataKeyName,mimeType:mimeType,imageQuality:imageQuality, progress: { (percent) in

            progress(percentage: percent)
            }, success: { (response) in
                success(response: response)
                
            }) { (errorType) in
                failure(errorType)
        }
    }
    
    /**
     *	@functionName	: downloadData
     *	@parameters		: url : It would be a unique identifier of device
                        :  completion block : It would be a unique identifier of device
     *	@description	: It would be used to download any Data
     */

    public class func downloadData(actionName:String, param:NSDictionary,progress:(percentage: Float)->Void, success:(response:NSDictionary)->Void, failure:NSError-> Void){
        
        TSGHelper.downloadFile(actionName, param: param, progressValue: { (percentage) in
            progress(percentage: percentage)
            }, success: { (response) in
                success(response: response)
            }) { (NSError) in
              failure(NSError)
        }
    }
    
    public class func getAPIVersion(onSuccess:(dic:NSDictionary)->()){
        
        TSGHelper.sharedInstance.getAPIVersion({ (dic) in
                    onSuccess(dic: dic)
            }) { (_) in
                
        }    }
}