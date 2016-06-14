//
//  ServiceManager.swift
//  TSGServiceClient
//
//  Created by Yogesh Bhatt on 14/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation

public class ServiceManager {
    
    /*********************************************************************************************************************
     
     These methods would only work when we Don't use TSG WEB CLIENT
     ********************************************************************************************************************/

    
    
    /**
     *	@functionName	: setHeader
     *	@parameters		: someDict : It would be dictionary of required set of Headers
     *	@description	: Call services for device reg and google analytics
     */
    
    public class func setHeader(someDict:[NSObject:AnyObject])
    {
        
        TSGHelper.setCustomHeader(someDict)
    }
    
    public class func setContentType(contentType:String) {
        
        // print(contentType)
       // TSGHelper.sharedInstance.setContentType = contentType
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
    
    public class func downloadData(endPoint:String, param:NSDictionary?=nil,requestType:RequestType,progress:(percentage: Float)->Void, success:(response:AnyObject)->Void, failure:NSError-> Void){
        
        TSGHelper.downloadFile(endPoint, param: param,requestType: requestType, progressValue: { (percentage) in
            progress(percentage: percentage)
            }, success: { (response) in
                success(response: response)
        }) { (NSError) in
            failure(NSError)
        }
    }
    
    /**
     *	@functionName	: setBaseURL
     *	@parameters		: url : It would be the baseURL of app
     */
    
    public class func setBaseURL(url:String)->() {
        TSGHelper.setBaseURL(url)
    }
    
    /**
     *	@functionName	: hitRequestForAPI
     *	@parameters		: name : It would the name of API to hit for getting response
     : requestType  : It would be HTTP action i.e GET,POST,DELTE,PUT
     : responseType : It would be responseType i.e JSON,XML, RAW
     
     *	@description	: It would be used to download any Data
     */
    
    public class func hitRequestForAPI(name:String, requestType:RequestType, responseType:ResponseMethod, success:(AnyObject) ->(), failure:(AnyObject)->()){
        
        TSGHelper.hitRequestForAPI(name, typeOfRequest: requestType, typeOFResponse: responseType, success: { (object) in
            success(object)
        }) { (error) in
            failure(error)
        }
    }
    
    /**
     *	@functionName	: resumeDownLoad
     *	@parameters		: url : It would be resume URL of Download
     */
    public class func resumeDownLoad(url:String, success:(Int64, totalBytes:Int64)->()){
        TSGHelper.resumeDownloads(url) { (bytes, totalBytes) in
            success(bytes,totalBytes: totalBytes)
        }
    }
    //Dowload can be anything get, post
    //Upload Data can be anything
    //Cancel AnyRequest
    //HitAnyRequest
    
}

