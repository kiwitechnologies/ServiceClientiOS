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
    var setContentType:String?
    var apiHeaderDict:NSMutableDictionary!
    let mutRequestDict:NSMutableDictionary = NSMutableDictionary ()
    
    var appRuningMode:AppRuningModeType {
        didSet
        {
            let path = NSBundle.mainBundle().pathForResource("api_validation", ofType: "json")
            let data : NSData = try! NSData(contentsOfFile: path! as String, options: NSDataReadingOptions.DataReadingMapped)
            let dict: NSDictionary!=(try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            let mutDict:NSMutableDictionary = NSMutableDictionary (dictionary: dict)
            
            
            switch appRuningMode {
                
            case .STAGING,.TESTING,.DEVELOPMENT:
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
    
    var pid:String!
    var baseUrl:String!
    var action:String!
    var apiName:String!
    
    //Alamofire Manager
    var manager:Manager!
    
    /*
     *Singleton method
     */
    public class var sharedInstance: TSGHelper {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: TSGHelper? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = TSGHelper()
        }
        return Static.instance!
    }
    
    var serviceCount:Int{
        
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
        setAppRuningMode()
        
    }
    
    internal func setAppRuningMode(){
        self.appRuningMode = .DEVELOPMENT
    }
    
    public func setDefaultHeader()
    {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        self.manager = Manager(configuration: configuration)
    }
    
    internal class func setCustomHeader(dict:[NSObject:AnyObject]){
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        configuration.HTTPAdditionalHeaders = dict
        TSGHelper.sharedInstance.manager = Manager(configuration: configuration)
        
        if (TSGHelper.sharedInstance.apiHeaderDict != nil) {
            TSGHelper.sharedInstance.apiHeaderDict.removeAllObjects() }
        
        TSGHelper.sharedInstance.apiHeaderDict = NSMutableDictionary(dictionary: configuration.HTTPAdditionalHeaders!)
        
    }
    
    public class func removeCustomHeader() {
        TSGHelper.sharedInstance.setDefaultHeader()
        
    }
    
    public class func requestedApi(actionID:String,withQueryParam queryParamDict:[String:String]?=nil, withParam params:[String:String]?=nil ,withTag apiTag:String?=nil, onSuccess success:(AnyObject)->(),
                                   onFailure failed:(Bool,NSError)->()){
        let obj = TSGHelper.sharedInstance
        
        TSGValidationManager.validateActionData(actionID,withQueryParma: queryParamDict, withDic: params,withHeaderDic:TSGHelper.sharedInstance.apiHeaderDict,withOptionalData: nil, onSuccess: { (apiName, string) in
            let apiObj:API = apiName as! API
            
            var requestType:RequestType!
            
            for category in RequestType.allValues{
                if apiObj.actionType == category.hashValue{
                    requestType = category
                    break
                }
            }
            
            var completeURL:String!
            
            if TSGHelper.sharedInstance.appRuningMode == .DEVELOPMENT  {
                completeURL = apiObj.dev_baseURL! + apiObj.actionName!
            } else if TSGHelper.sharedInstance.appRuningMode == .TESTING {
                completeURL = apiObj.qa_baseURL! + apiObj.actionName!

            } else if TSGHelper.sharedInstance.appRuningMode == .STAGING {
                completeURL = apiObj.stage_baseURL! + apiObj.actionName!

            } else if TSGHelper.sharedInstance.appRuningMode == .PRODUCTION {
                completeURL = apiObj.prod_baseURL! + apiObj.actionName!
            }

            obj.getDataFromUrl(completeURL,withActionID:actionID, withQueryParam:queryParamDict, params: params, typeOfRequest:requestType, typeOfResponse: .JSON, success: { (dict) in
                
                success(dict)
                }, failure: { (dict) in
                    let error:NSError = NSError(domain: "", code: -10004, userInfo: ["Response Error":dict])
                    failed(true, error)
            })
            
        }) { (error) in
            failed(true,error)
        }
    }
    
 public class func setProjectRuningMode(releaseMode:AppRuningModeType) {
        
        let obj = TSGHelper.sharedInstance
        obj.pid = NSUserDefaults().valueForKey("ProjectID") as? String
        
        obj.appRuningMode = releaseMode
        
    }
    
    internal func setBaseURL(url:String) {
        self.baseUrl = url
    }
    
    /**
     - Http request using GET,POST,PUT,DELETE
     - parameter url:   The URL string.
     - parameter params:  Parameters in the form of dictionary.
     - parameter typeOfRequest: Specify Request type
     - parameter returnResponse: block handles the response
     */
    
    internal func getDataFromUrl( url:String,withActionID actionID:String, withQueryParam queryParamDict:[String:String]?=nil, params:NSDictionary?=nil,typeOfRequest:RequestType, typeOfResponse:ResponseMethod, withApiTag apiTag:String?=nil, success: AnyObject -> Void,failure: NSError -> Void)
    {
        
        self.serviceCount = self.serviceCount + 1
      //  url = "\(url)"
        
        switch(typeOfRequest)
        {
        case RequestType.GET:
            
            self.req =  self.manager.request(.GET,url, parameters: params as? [String : AnyObject], queryParameters: queryParamDict)
            
            
        case RequestType.POST:
            
            self.req =  self.manager.request(.POST,url, parameters: params as? [String : AnyObject], queryParameters:queryParamDict,  encoding: .JSON)
            
        case RequestType.PUT:
            
            self.req = self.manager.request(.PUT,url, parameters: params as? [String : AnyObject], encoding: .JSON)
            
        case RequestType.DELETE:
            
            self.req =  self.manager.request(.DELETE, url, parameters: params as? [String : AnyObject], encoding: .JSON)
        }
        
        
        var requestArray:NSMutableArray!
        
        if self.mutRequestDict.objectForKey(actionID) != nil {
            requestArray = self.mutRequestDict.objectForKey(actionID) as! NSMutableArray
            
        }
        
        if(requestArray == nil || requestArray.count == 0)
        {
            requestArray = NSMutableArray()
            req?.requestTAG = 0
            requestArray.addObject(self.req!)
            
        }
        else
        {
            let lastRequest = requestArray.lastObject as! Request
            self.req?.requestTAG = lastRequest.requestTAG + 1
            requestArray.addObject(self.req!)
            
        }
        
        self.mutRequestDict.setObject(requestArray, forKey: actionID)
        
        let requestTag =  self.req?.requestTAG
        
        
        let actionID = actionID
        switch(typeOfResponse)
        {
            
        case ResponseMethod.JSON:
            self.req?.responseJSON
                { response in
                    
                    let arr:NSMutableArray! = self.mutRequestDict.objectForKey(actionID)  as! NSMutableArray
                    
                    if(arr != nil || arr.count != 0)
                    {
                        if(arr.count == 1)
                        {
                            arr.removeAllObjects()
                            self.mutRequestDict.removeObjectForKey(actionID)
                        }
                        else
                        {
                            let lRequestArray = NSArray(array: arr)
                            for req in lRequestArray
                            {
                                let runningReq =  req as! Request
                                if(runningReq.requestTAG == requestTag)
                                {
                                    arr.removeObject(req)
                                    break;
                                }
                            }
                            
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            self.serviceCount = self.serviceCount - 1
                            
                            if response.response?.statusCode <= 200 {
                                
                                if response.result.value != nil {
                                    success(response.result.value!)
                                } else {
                                    failure(response.result.error!)
                                }
                                
                            } else {
                                if response.result.error != nil {
                                    failure(response.result.error!)
                                }
                            }
                    })
                    
            }
            
        case ResponseMethod.RAW: break
        case ResponseMethod.DATA: break
        }
    }
    
    //Mutlipart upload file method
    /**
     Upload any file in the form of NSData
     - parameter url: upload url
     - parameter imageData:  File data to upload.
     - parameter success: Block to handle response
     - parameter failure: Block to handle error
     */
    
    public class func uploadFile(actionName: String,bodyParams:NSDictionary, dataKeyName:String,mimeType:MimeType,imageQuality:ImageQuality?=ImageQuality.HIGH, progress: (percent: Float) -> Void, success:(response:AnyObject) -> Void, failure:ErrorType->Void)
    {
        let obj = TSGHelper.sharedInstance
        
        //let imageData = bodyParams.valueForKey(dataKeyName) as! NSData
        
        let imageData = TSGHelper.sharedInstance.changeImageResolution(bodyParams.valueForKey(dataKeyName) as! NSData, withImageQuality: imageQuality!)
        
        let dictParams = NSMutableDictionary(dictionary:bodyParams)
        dictParams.removeObjectForKey(dataKeyName)
        
        let mimeType:String = obj.returnMimeType(mimeType)
        
        TSGValidationManager.validateActionData(actionName, withDic: bodyParams,withHeaderDic: TSGHelper.sharedInstance.apiHeaderDict, withOptionalData:imageData , onSuccess: { (object, str) in
            
            var completeURL:String!
            
            if TSGHelper.sharedInstance.appRuningMode == .DEVELOPMENT  {
                completeURL = (object as! API).dev_baseURL! + (object as! API).actionName!
            } else if TSGHelper.sharedInstance.appRuningMode == .TESTING {
                completeURL = (object as! API).qa_baseURL! + (object as! API).actionName!
                
            } else if TSGHelper.sharedInstance.appRuningMode == .STAGING {
                completeURL = (object as! API).stage_baseURL! + (object as! API).actionName!
                
            } else if TSGHelper.sharedInstance.appRuningMode == .PRODUCTION {
                completeURL = (object as! API).prod_baseURL! + (object as! API).actionName!
            }

            print("*************************\(completeURL)")
            obj.manager.upload(
                .POST,
                completeURL,
                multipartFormData: { multipartFormData in
                    multipartFormData.appendBodyPart(data: imageData, name: dataKeyName,
                        fileName: "\(dataKeyName).\(mimeType.componentsSeparatedByString("/").last!)", mimeType: mimeType)
                    
                    for (key, value) in dictParams {
                        multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key as! String)
                    }
                    
                },
                encodingCompletion: { encodingResult in
                    
                    switch encodingResult {
                        
                    case .Success(let upload, _, _):
                        
                        upload.progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                            dispatch_async(dispatch_get_main_queue()) {
                                let percent = (Float(totalBytesWritten) / Float(totalBytesExpectedToWrite))
                                progress(percent: percent)
                                
                            }
                        }
                        //  upload.validate()
                        upload.responseJSON(completionHandler: { (response) in
                            print("i M IN \(response.response?.statusCode)")

                            dispatch_async(dispatch_get_main_queue(),
                                {
                                    obj.serviceCount = obj.serviceCount - 1
                                    
                                    if response.response?.statusCode <= 200 {
                                        
                                        if response.result.value != nil {
                                            success(response: response.result.value!)
                                        } else {
                                            failure(response.result.error!)
                                        }
                                        
                                    } else {
                                        if response.result.error != nil {
                                            failure(response.result.error!)
                                        }
                                    }
                            })
                            
                            //    success(response:response.result.value!)
                            
                        })
                        
                        
                    case .Failure(let encodingError):
                        print("Encoding error------------------------\(encodingError)")
                    }
                }
            )
            
        }) { (error) in
            print(error)
        }
        
    }
    
    internal func changeImageResolution(imageData:NSData, withImageQuality imageQuality:ImageQuality)-> NSData {
        
        let imageSize:Int = imageData.length
        let imageKBSize:Int = imageSize/1024
        var imgData: NSData!
        
        let image = UIImage(data: imageData)
        
        switch imageQuality {
        case .HIGH:
            if imageKBSize > 3000 {
                imgData =  UIImageJPEGRepresentation(image!, 0.7)!
                
            }
            break
        case .LOW:
            if imageKBSize > 1500 {
                imgData =  UIImageJPEGRepresentation(image!, 0.3)!
                
            }
            break
        case .MEDIUM:
            if imageKBSize < 3000 && imageKBSize > 1500 {
                imgData =  UIImageJPEGRepresentation(image!, 0.5)!
                
            }
            break
            
        }
        return imgData
    }
    
    /*
     Download any file
     - paramter url: Download url
     - parameter success: Block to handle response
     - parameter failure: Block to handle error
     */
    
    public class func downloadFile(actionName:String, param:NSDictionary,progressValue:(percentage:Float)->Void, success:(response:NSDictionary) -> Void, failure:NSError->Void)
    {
        let obj = TSGHelper.sharedInstance
//        
//        let destination: (NSURL, NSHTTPURLResponse) -> (NSURL) = {
//            (temporaryURL, response) in
//            
//            if let directoryURL:NSURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] {
//                
//                let localImageURL = directoryURL.URLByAppendingPathComponent("\(response.suggestedFilename!)")
//                return localImageURL
//            }
//            return temporaryURL
//        }
//        
//        print(destination)
        let destination = Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)

        obj.req =  obj.manager.download(.GET, "http://www.charts.noaa.gov/BookletChart/11441_BookletChart.pdf",parameters:nil,
            destination: destination)
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                let percentage = (Float(totalBytesRead) / Float(totalBytesExpectedToRead))
                progressValue(percentage: percentage)
            }
            .response { _,response, _, error in
                print(error)
        }

    }
    
    /**
     Resume any pending downloads
     - paramter url: Resume download url
     - parameter success: Block to handle response
     */
    internal func resumeDownloads(url:String,success:(Int64,totalBytes:Int64)-> Void)
    {
        let obj = TSGHelper.sharedInstance
        
        obj.serviceCount = obj.serviceCount + 1
       let url = "\(obj.baseUrl)\(url)"
        let destination = Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        obj.req =  obj.manager.download(.GET, url, destination: destination)
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                success(totalBytesRead,totalBytes:totalBytesExpectedToRead)
            }.response { _, _, _, _ in
                if let
                    resumeData = obj.req!.resumeData,
                    _ = NSString(data: resumeData, encoding: NSUTF8StringEncoding)
                {
                    obj.serviceCount = obj.serviceCount - 1
                } else {
                    obj.serviceCount = obj.serviceCount - 1
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
        
        
        obj.getDataFromUrl(urlString,withActionID:"Default", params: [:], typeOfRequest: .GET, typeOfResponse: .JSON, success: { (obj) in
            
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
    
    /**
     Cancel any ongoing alamofire operation
     */
    public class func cancelAllRequests() {
        let obj = TSGHelper.sharedInstance
        
        let allKeys = obj.mutRequestDict.allKeys
        
        for key in allKeys {
            
            if let req:NSMutableArray = (obj.mutRequestDict.valueForKey(key as! String) as? NSMutableArray)! {
                for key in req {
                (key as! Request).cancel()
                    print("CancelRequest with \((key as! Request))")

                }
            }
        }
        
    }
    
    public class func cancelRequestWithTag(actionID:String) {
        
        let obj = TSGHelper.sharedInstance
        
        if let req = (obj.mutRequestDict.valueForKey(actionID )) {
            for key in req as! NSMutableArray {
                (key as! Request).cancel()
                print("CancelRequest with \((key as! Request))")
                
            }
        }
    }
    
    internal func returnMimeType(mimeType:MimeType) -> String {
        
        switch mimeType {
        case .TEXT_FILE:
            return "text/plain"
            
        case .JPEG_IMAGE:
            return "image/jpeg"
            
        case .PNG_IMAGE:
            return "image/png"
            
        case .VIDEO:
            return "video/mp4"
            
        case .PDF:
            return "application/pdf"
        }
    }
}
