//
//  AlamofireManager.swift
//  Alamofire
//
//  Created by Ayush Goel on 26/10/15.
//  Copyright © 2015 Ayush Goel. All rights reserved.
//
//This class implements the Alamofire methods

import UIKit

public class TSGHelper: NSObject
{
    var appVersion:String?
    var projectOBJ:Project?
    var req:Request?
    var apiHeaderDict:NSMutableDictionary!
    
    var normalActionRequest:NSMutableArray = NSMutableArray()
    var sequentialDownloadRequest:NSMutableArray = NSMutableArray()
    var parallelDownloadRequest:NSMutableArray = NSMutableArray()

    var sequentialUploadRequest:NSMutableArray = NSMutableArray()
    var parallelUploadRequest:NSMutableArray = NSMutableArray()

    //Alamofire Manager
    var manager:Manager!
    var pid:String!
    var baseUrl:String!
    var action:String!
    var apiName:String!
    var responseCode:Int = 200
    var encodingType:ParameterEncoding = .JSON
    var enableLog:Bool = false
    var success:(response:AnyObject) -> Void? = {_ in return}
    var progress: (percent: Float) -> Void? = {_ in return}
    var failure:NSError->Void? = {_ in return}
    /*
     *Singleton method
     */
    public class var sharedInstance: TSGHelper
    {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: TSGHelper? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = TSGHelper()
            Static.instance?.appRuningMode = .DEVELOPMENT
        }
        return Static.instance!
    }
    
  
    var serviceCount:Int
        {
        didSet
        {
            if(self.serviceCount == 0)
            {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
            }
            else
            {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            }
        }
    }
    
    override init()
    {
        self.serviceCount = 0
        self.appRuningMode = .DEVELOPMENT
        super.init()
        setDefaultHeader()
    }
    
    public func setDefaultHeader()
    {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        self.manager = Manager(configuration: configuration)
    }
    
    public class func setBaseURL(url:String)
    {
        TSGHelper.sharedInstance.baseUrl = url
    }
    
    internal class func setCustomHeader(dict:[NSObject:AnyObject])
    {
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        configuration.HTTPAdditionalHeaders = dict
        TSGHelper.sharedInstance.manager = Manager(configuration: configuration)
    }
    
    public class func removeCustomHeader()
    {
        TSGHelper.sharedInstance.setDefaultHeader()
    }
    
    public class func setEncoding(encoding:ParameterEncoding)
    {
        TSGHelper.sharedInstance.encodingType = encoding
    }
    
    
    
    /*************************************************************************************************************************************      ALL WEB-TOOL METHODS
     
    *************************************************************************************************************************************/
    
    //MARK: WEB tool methods
    var appRuningMode:AppRuningModeType
    {
        didSet
        {
            let path = NSBundle.mainBundle().pathForResource("api_validation", ofType: "json")
            if(path != nil)
            {
                let data : NSData = try! NSData(contentsOfFile: path! as String, options: NSDataReadingOptions.DataReadingMapped)
                let dict: NSDictionary!=(try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                let mutDict:NSMutableDictionary = NSMutableDictionary (dictionary: dict)
                switch appRuningMode
                {
                
                case .STAGING,.TESTING,.DEVELOPMENT, .DUMMY:
                saveProjectID(mutDict)
                break
                case .PRODUCTION:
                
                if let projectID = Project.getProjectDetail(pid) {
                    getAPIVersion({ (dic) in
                        
                        if (dict.valueForKey("result") as! String).rangeOfString("Success") != nil {
                            self.projectOBJ = projectID as? Project
                            self.appVersion = self.projectOBJ!.versionNumber!
                        } else {
                            self.saveProjectID(mutDict)
                            
                        }
                        }, failure: { (_) in
                            self.projectOBJ = projectID as? Project
                            self.appVersion = self.projectOBJ!.versionNumber!
                    })
                    
                    } else {
                    saveProjectID(mutDict)
                    }
                    break
                }
               
                
            }
        }
    }
 
    
    internal func saveProjectID(dict:NSMutableDictionary) {
        Project.saveProjectInfo(dict)
    }
    
    internal func getAPIVersion( sucess:(dic:NSDictionary)->(), failure:(error:NSError)-> ()){
        
        let obj = TSGHelper.sharedInstance
        projectOBJ = Project.getProjectDetail(pid) as? Project
        var dict:NSDictionary!
        
        let string = projectOBJ?.projectID
        
        let urlString:String! = "http://kiwitechopensource.com/tsg/projects/\((string!))/version"
        
        
        obj.getDataFromUrl(urlString,withApiTag: "0", bodyParams: [:], typeOfRequest: .GET, typeOfResponse: .JSON, success: { (obj) in
            
            var result:String!
            
            if obj.valueForKey("version_no")! as! NSNumber == (self.projectOBJ?.apiVersion!)!{
                result = "Success! Version numbers are matching"
            } else {
                result = "Failed! Version numbers are not matching"
                
            }
            
            dict = ["server_api_version_no":obj.valueForKey("version_no")!, "local_api_version_no":(self.projectOBJ?.apiVersion)!,
                "Result":result]
            
            
            sucess(dic: dict)
        }) { (error) in
            print("Faliure \(error)")
            failure(error: error)
        }
    }
    
    public class func requestedApi(actionID:String,withQueryParam queryParamDict:[String:AnyObject]?=nil, withBodyParam bodyParams:[String:AnyObject]?=nil ,withPathParams pathParamDict:[String:AnyObject]?=nil, withTag apiTag:String?=nil, onSuccess success:(AnyObject)->(),
                                   onFailure failed:(Bool,NSError)->()){
        let obj = TSGHelper.sharedInstance
        var completeURL:String!

        
        TSGValidationManager.validateActionData(actionID,withQueryParma: queryParamDict, withBodyParam: bodyParams,withHeaderDic:TSGHelper.sharedInstance.apiHeaderDict, withOptionalData: nil, onSuccess: { (apiName, string) in
            
            var queryParam:[String:AnyObject]!
            if queryParamDict != nil {
                queryParam = queryParamDict

            }
            
            let apiObj:API = apiName as! API
            var requestType:RequestType!
            
            for category in RequestType.allValues{
                if apiObj.actionType == category.hashValue{
                    requestType = category
                    break
                }
            }

            if TSGHelper.sharedInstance.appRuningMode == .DEVELOPMENT  {
                completeURL = apiObj.dev_baseURL! + apiObj.actionName!
                
            } else if TSGHelper.sharedInstance.appRuningMode == .TESTING {
                completeURL = apiObj.qa_baseURL! + apiObj.actionName!
                
            } else if TSGHelper.sharedInstance.appRuningMode == .STAGING {
                completeURL = apiObj.stage_baseURL! + apiObj.actionName!
                
            } else if TSGHelper.sharedInstance.appRuningMode == .PRODUCTION {
                completeURL = apiObj.prod_baseURL! + apiObj.actionName!
            } else if TSGHelper.sharedInstance.appRuningMode == .DUMMY {
                completeURL = apiObj.dummy_server_URL! //+ apiObj.actionName!
                queryParam = ["status_code":"\(TSGHelper.sharedInstance.responseCode)"]

            }

            if apiObj.params_parameters == 1 {

                TSGUtility.createPathParamURL(completeURL, pathParamDict: pathParamDict!, setString: { (completeString) in
                    completeURL = completeString

                    }, error: { (error) in
                            errorMessage = error
                            TSGValidationManager.sharedInstance.tsgErrorManger!.pathParameter.missingErrorMessages("", errorMsg: errorMessage)
                            let str:String = TSGValidationManager.sharedInstance.tsgErrorManger!.mystring()
                            
                            if TSGValidationManager.sharedInstance.tsgErrorManger != nil {
                                TSGValidationManager.sharedInstance.tsgErrorManger = nil
                                TSGValidationManager.sharedInstance.tsgErrorManger = TSGErrorManager()
                            }
                            if let data = str.dataUsingEncoding(NSUTF8StringEncoding) {
                                do {
                                    let temp:[String:AnyObject] = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String : AnyObject]
                                    failed(true,NSError(domain: "Failed", code: 1004, userInfo:[NSLocalizedDescriptionKey : temp]))
                                } catch _ {
                                }
                            }
                })
            }
            
            var tag:String!
            
            if apiTag == nil {
                tag = "0"
            }else {
                tag = apiTag
            }
            if completeURL != nil {
                obj.getDataFromUrl(completeURL, withApiTag: tag!, withQueryParam: queryParam, bodyParams: bodyParams, typeOfRequest: requestType, typeOfResponse: .JSON, success: { (dict) in
                    success(dict)
                    }, failure: { (error) in
                        failed(true, error)
                })
            }
            
        }) { (error) in
            failed(true,error)
        }
        
    }
    
    public class func setResponseCode(code:Int){
        TSGHelper.sharedInstance.responseCode = code
    }
    
    public class func setProjectRuningMode(releaseMode:AppRuningModeType)
    {
        let obj = TSGHelper.sharedInstance
        obj.pid = NSUserDefaults().valueForKey("ProjectID") as? String
        obj.appRuningMode = releaseMode
    }


    /*************************************************************************************************************************************      NON WEB-TOOL METHODS
     
     *************************************************************************************************************************************/
    //MARK:  NON-WebTool Methods

    class func hitRequestForAPI(path:String, withQueryParam queryParam:[String:String]?=nil, bodyParam:NSDictionary?=nil,typeOfRequest:RequestType, typeOFResponse:ResponseMethod, withApiTag apiTag:String?=nil, success:AnyObject->Void, failure:NSError -> Void){
        
        var completeURL:String!
        
        if TSGHelper.sharedInstance.baseUrl != nil {
            completeURL = TSGHelper.sharedInstance.baseUrl + path
        }
        else {
            completeURL = path
        }
        
        var actionID:String!
        
        if apiTag != nil {
            actionID = apiTag
        } else {
            actionID = "0"
        }
       
        TSGHelper.sharedInstance.getDataFromUrl(completeURL,withApiTag: actionID!, withQueryParam: queryParam, bodyParams: bodyParam, typeOfRequest: typeOfRequest, typeOfResponse: typeOFResponse, success: { (object) in
            success(object)
            
        }) { (error) in
            failure(error)
        }

    }
    

    /**
     - Http request using GET,POST,PUT,DELETE
     - parameter url:   The URL string.
     - parameter params:  Parameters in the form of dictionary.
     - parameter typeOfRequest: Specify Request type
     - parameter returnResponse: block handles the response
     */
    
    //MARK: Common Methods

    internal func getDataFromUrl( url:String, withApiTag apiTag:String, withQueryParam queryParamDict:[String:AnyObject]?=nil, bodyParams:NSDictionary?=nil,typeOfRequest:RequestType, typeOfResponse:ResponseMethod, success: AnyObject -> Void,failure: NSError -> Void)
    {
        self.serviceCount = self.serviceCount + 1
        
        let obj = TSGHelper.sharedInstance
        
        if TSGHelper.sharedInstance.enableLog {
            print("Request Type:----------------\(typeOfRequest)")
            print("Request URL :----------------\(url)")
            print("QuerParams  :----------------\(queryParamDict)")
            print("BodyParams  :----------------\(bodyParams)")
        }
        
        switch(typeOfRequest)
        {
        case RequestType.GET:
            
            self.req =  self.manager.request(.GET,url, parameters: bodyParams as? [String : AnyObject], queryParameters: queryParamDict as? [String:String], encoding: self.encodingType)
            
            
        case RequestType.POST:
            
            self.req =  self.manager.request(.POST,url, parameters: bodyParams as? [String : AnyObject], queryParameters:queryParamDict as? [String:String],  encoding: self.encodingType)
            
        case RequestType.PUT:
            
            self.req = self.manager.request(.PUT,url, parameters: bodyParams as? [String : AnyObject], encoding: self.encodingType)
            
        case RequestType.DELETE:
            
            self.req =  self.manager.request(.DELETE, url, parameters: bodyParams as? [String : AnyObject], encoding: self.encodingType)
        }
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()

        let progressValue:(percentage:Float)->()? = { percent in return}
        progressValue(percentage: 1.0)
        
        obj.normalActionRequest.addObject(RequestModel(url: url, bodyParam: bodyParams, queryParam: queryParamDict, type: typeOfRequest, state: true, apiTag: apiTag, priority: true, actionType: .NORMAL,apiTime:"\(currentTime)",requestObj: self.req,progressBlock: progressValue, successBlock: success,  failureBlock: failure))
        let requestTag =  self.req?.requestTAG

        switch(typeOfResponse)
        {
            
        case ResponseMethod.JSON:
            self.req?.responseJSON
                { response in
                    
                    let matchingObjects = self.normalActionRequest.filter({return ($0 as! RequestModel).apiTag == requestTag})
                    
                    for object in matchingObjects {
                        
                        for serialObj in self.normalActionRequest {
                            if (object as! RequestModel).apiTag == (serialObj as! RequestModel).apiTag{
                                self.normalActionRequest.removeObject(object)
                            }
                        }

                    }
                    
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            self.serviceCount = self.serviceCount - 1
                            if response.response?.statusCode < 400
                            {
                                if response.result.value != nil
                                {
                                    success(response.result.value!)
                                }
                                else
                                {
                                    if response.result.error != nil
                                    {
                                        failure(response.result.error!)
                                    }
                                }
                                
                            }
                            else
                            {
                                if response.result.value != nil
                                {
                                    let error = NSError(domain: "Server Error", code: (response.response?.statusCode)!, userInfo: response.result.value! as? [NSObject : AnyObject])
                                    failure(error)

                                }
                                if response.result.error != nil
                                {
                                    failure(response.result.error!)
                                }
                            
                            }
                    })
            }
            
        case ResponseMethod.RAW: break
        case ResponseMethod.DATA: break
            
        }
    }
    
    /**
     *	@functionName	: enableLog
     *	@parameters		: enable : Set log.
     *	@description	: It would be used to set response code for which user wants response in apis
     */
    
    public class func enableLog(enable:Bool){
       TSGHelper.sharedInstance.enableLog = enable
    }
}
