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
 
    
/*********************************************************************************************************************
 
 These methods would only work when we use TSG WEB CLIENT
********************************************************************************************************************/

    /**
     *	@functionName	: setTimeInterval
     *	@parameters		: timeInterval : Set timeInterval.
     *	@description	: It would be used to set time interval for which service would wait to get compelte response
     */
    
    public class func setTimeOutInterval(timeInterval:Double){
        TSGHelper.setTimeInterval(timeInterval)
    }
    
    
    /**
     *	@functionName	: setConfiguration
     *	@parameters		: enable : Set allow BackGround.
     *	@description	: It would be used to set response code for which user wants response in apis
     */
    
    public class func setBackGroundConfiguration(allowBackground:Bool, bundleID:String?=nil){
       // TSGHelper.setBGSetting(allowBackground, bundleID: bundleID!)
    }
    /**
     *	@functionName	: enableLog
     *	@parameters		: enable : Set log.
     *	@description	: It would be used to set response code for which user wants response in apis
     */
    
    public class func enableLog(enable:Bool){
        TSGHelper.enableLog(enable)
    }
    
    /**
     *	@functionName	: setResponseCode
     *	@parameters		: code : It would be a response code.
     *	@description	: It would be used to set response code for which user wants response in apis
     */
    
    public class func setResponseCode(code:Int){
        TSGHelper.setResponseCode(code)
    }
    
    /**
     *	@functionName	: setProjectRuningMode
     *	@parameters		: releaseMode : It would be a unique identifier of each Project
     *	@description	: It would be used to set projectID in app
     */
    
    public class func setProjectRuningMode( releaseMode:AppRuningModeType) {
        
        TSGHelper.setProjectRuningMode(releaseMode)
    }
    
    /**
     *	@functionName	: setEncoding
     *	@parameters		: encoding : URL-Nested, JSON- Default
     *	@description	: It would be used to set encoding Type
     */
    
    public class func setEncoding(encoding:ParameterEncoding)
    {
        TSGHelper.setEncoding(encoding)
    }
    
    /**
     *	@functionName	: setHeader
     *	@parameters		: someDict : It would be dictionary of required set of Headers
     *	@description	: Call services for device reg and google analytics
     */
    
    public class func setHeader(someDict:[NSObject:AnyObject])
    {
        
        TSGHelper.setCustomHeader(someDict)
    }
    
    /**
     *	@functionName           : removeHeader
     *	@completion Block		: deviceTokeString : It would be a unique identifier of device
     *	@description            : It would be used to remove Headers
     */
    
    public class func removeHeader()
    {
        TSGHelper.removeCustomHeader()
        
    }
    
    /**
     *	@functionName	: cancelAllRequest
     *	@description	: It would be used to cancel request
     */
    
    public class func cancelAllRequest(completion:(Bool)->())
    {
        TSGHelper.cancelAllRequests()
    }
    
    
    /**
     *	@functionName	: performAction
     *	@parameters		: actionID : It would be ID of api which we request to get response
                        : dict : It would be a required dictionary to pass to api
     *	@return			:
     *	@description	: It would be used to make request for any(REST api) and to recieve response
     */
    

    public class func performAction(actionID:String?=nil,withQueryParam queryParamDict:[String:AnyObject]?=nil, withBodyParams bodyDict:[String:AnyObject]?=nil,withPathParams pathParamDict:[String:AnyObject]?=nil ,withTag apiTag:String?=nil,cachePolicy:NSURLRequestCachePolicy?=nil, onSuccess success:(AnyObject)->(), onFailure failed:(Bool, NSError)->()){

        TSGHelper.requestedApi(actionID!,withQueryParam: queryParamDict, withBodyParam: bodyDict,withPathParams: pathParamDict, withTag:apiTag,cachePolicy:cachePolicy,  onSuccess: { (dictionary) in
            success(dictionary)
            }) { (bool, error) in
            failed(bool,error)
        }
    }
    
    /**
     *	@functionName	: cancelRequestWithActionID
     *	@description	: It would be used to cancel request
     */
    
    public class func cancelRequestWithTagId(tagID:String)->()
    {
        TSGHelper.cancelRequestWithTag(tagID)
    }
    
    /**
     *	@functionName	: downloadData
     *	@parameters		: url : It would be a unique identifier of device
     :  completion block : It would be a unique identifier of device
     *	@description	: It would be used to download any Data
     */
    
    public class func downloadData(endPoint:String, param:NSDictionary?=nil,requestType:RequestType, downloadType:DownloadType = DownloadType.PARALLEL,withTag apiTag:String?=nil,priority:Bool, downloadingPath:String?=nil,fileName:String?=nil,progress:(percentage: Float)->Void, success:(response:AnyObject)->Void, failure:NSError-> Void){
        
        TSGHelper.downloadFile(endPoint, param: param,requestType: requestType,downloadType:downloadType,priority: priority, downloadingPath: downloadingPath,fileName: fileName,progressValue: { (percentage) in
            progress(percentage: percentage)
            }, success: { (response) in
                success(response: response)
        }) { (NSError) in
            failure(NSError)
        }
    }
    
    
    /**
     *	@functionName	: uploadData
     *	@parameters		: imageData : It would be a unique identifier of device
     *	@description	: It would be used to upload the data
     */
    
    public class func uploadData(actionID:String, mimeType:MimeType,queryParam:NSDictionary?=nil,bodyParams:NSDictionary,dataKeyName:String,imageQuality:ImageQuality,withTag apiTag:String?=nil,uploadType:UploadType = UploadType.PARALLEL,requestType:RequestType,prority:Bool, progress: (percentage: Float) -> Void, success:(response:AnyObject) -> Void, failure:ErrorType->Void) {
        
        TSGHelper.uploadFileWith(actionID, bodyParams: bodyParams,dataKeyName:dataKeyName,mimeType:mimeType,imageQuality:imageQuality,withApiTag:apiTag,uploadType: uploadType,priority: prority,requestType:requestType,  progress: { (percent) in

            progress(percentage: percent)
            }, success: { (response) in
                success(response: response)
                
            }) { (errorType) in
                failure(errorType)
        }
    }
    
    /**
     *	@functionName	: getAPIVersion
     *	@parameters		: onSuccess : It would give the version no.
     */
    
    public class func getAPIVersion(onSuccess:(dic:NSDictionary)->()){
        
        TSGHelper.sharedInstance.getAPIVersion({ (dic) in
                    onSuccess(dic: dic)
            }) { (_) in
        }
    }
}