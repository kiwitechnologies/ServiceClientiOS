//
//  TSGHelper+Download.swift
//  TSGServiceClient
//
//  Created by Yogesh Bhatt on 20/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation

extension TSGHelper{
    
    //MARK: A common method to download file
    public class func downloadFile(path:String, param:NSDictionary?=nil,requestType:RequestType ,downloadType:DownloadType = DownloadType.PARALLEL, withApiTag apiTag:String?=nil,priority:Bool, downloadingPath:String?=nil,fileName:String?=nil, progressValue:(percentage:Float)->Void, success:(response:AnyObject) -> Void, failure:NSError->Void)
    {
        
        let obj = TSGHelper.sharedInstance
        var objTag:String!
        
        if apiTag != nil {
            objTag = apiTag
        } else {
            objTag = "0"
        }
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        if downloadType == .SEQUENTIAL
        {
            
            if priority == true {
                obj.sequentialDownloadRequest.insertObject((RequestModel(url: path, bodyParam: param, type: requestType, state: true, apiTag: objTag, priority: priority, actionType: .DOWNLOAD, apiTime: "\(currentTime)", progressBlock: progressValue, successBlock: success, failureBlock: failure)), atIndex: 0)
                
            } else {
                obj.sequentialDownloadRequest.addObject(RequestModel(url: path, bodyParam: param, type: requestType, state: true, apiTag: objTag, priority: priority, actionType: .DOWNLOAD, apiTime: "\(currentTime)", progressBlock: progressValue, successBlock: success, failureBlock: failure))
            }
            
            if obj.sequentialDownloadRequest.count == 1 {
                
                obj.download(path, param: param, requestType: requestType,downloadType:.SEQUENTIAL, withApiTag: objTag, progressValue: { (percentage) in
                    progressValue(percentage: percentage)
                    },fileName:fileName, downloadingPath: downloadingPath, success: { (response) in
                        success(response: response)
                    }, failure: { (error) in
                        failure(error)
                })
                
            } else {
                
                let firstArrayObject:RequestModel = obj.sequentialDownloadRequest[0] as! RequestModel
                
                if firstArrayObject.isRunning == false{
                    obj.download(path, param: param, requestType: requestType, downloadType: .SEQUENTIAL, withApiTag: objTag, progressValue: { (percentage) -> Void? in
                        progressValue(percentage: percentage)

                        },fileName:fileName, downloadingPath: downloadingPath, success: { (response) -> Void? in
                            success(response: response)

                        }, failure: { (error) -> Void? in
                            failure(error)

                    })
                }
            }
            
        }
        else
        {
            obj.download(path, param: param, requestType: requestType,downloadType:.PARALLEL,  withApiTag: objTag, progressValue: { (percentage) in
                progressValue(percentage: percentage)
                },fileName:fileName, downloadingPath: downloadingPath, success: { (response) in
                    success(response: response)
                }, failure: { (error) in
                    failure(error)
            })
        }
    }
    
    func download(path:String, param:NSDictionary?=nil,requestType:RequestType,downloadType:DownloadType, withApiTag apiTag:String, progressValue:(percentage:Float)->Void?,downloadingPath:String?=nil,fileName:String?=nil, success:(response:AnyObject) -> Void?,  failure:NSError->Void?){
        
        self.success = success
        self.progress = progressValue
        self.failure = failure
        var localPath: NSURL?
        
        let obj = TSGHelper.sharedInstance
        var completeURL:String!
        
        if TSGHelper.sharedInstance.baseUrl != nil {
            completeURL = TSGHelper.sharedInstance.baseUrl + path
        }
        else {
            completeURL = path
        }
        
      //  let destination = Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)

        var requestMethod:Method = .GET
        
        switch requestType {
            
        case .GET:
            requestMethod = .GET
            
        case .POST:
            requestMethod = .POST
            
        case .DELETE:
            requestMethod = .DELETE
            
        case .PUT:
            requestMethod = .PUT
        }
        
        var firstArrayObject:RequestModel!
        
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0])
        
        var downloadPath:NSURL?// = documentsPath.URLByAppendingPathComponent("downloads123/DownloadsArticles")
        
        if downloadingPath != nil {
            downloadPath = documentsPath.URLByAppendingPathComponent(downloadingPath!)
            
            var isDirectory: ObjCBool = false
            
            if NSFileManager.defaultManager().fileExistsAtPath(downloadPath!.path!, isDirectory: &isDirectory) {
                if(!isDirectory){
                    do {
                        try NSFileManager.defaultManager().createDirectoryAtPath(downloadPath!.path!, withIntermediateDirectories: true, attributes: nil)
                    }catch  {
                        NSLog("Unable to create directory ")
                    }
                }
            }else{
                do {
                    try NSFileManager.defaultManager().createDirectoryAtPath(downloadPath!.path!, withIntermediateDirectories: true, attributes: nil)
                }catch  {
                    NSLog("Unable to create directory ")
                }
                
            }

        }
        
        if downloadType == .SEQUENTIAL {
            firstArrayObject = obj.sequentialDownloadRequest[0] as! RequestModel
        }
        
        obj.req =  obj.manager.download(requestMethod, completeURL,parameters:param as? [String : AnyObject],
            destination: { (temporaryURL, response) in
                var pathComponent:String!
                print("************************************")
                print(downloadPath)
                print("************************************")

                
                if fileName == nil {
                    pathComponent = response.suggestedFilename

                }
                else {
                    pathComponent = fileName
                }
                
                if downloadPath == nil {
                    let directoryURL = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)[0]
                    localPath = directoryURL.URLByAppendingPathComponent(pathComponent!)
                    return localPath!
                } else {
                    downloadPath = downloadPath!.URLByAppendingPathComponent(pathComponent!)

                }
                localPath = downloadPath
                return localPath!
        })
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                let percentage = (Float(totalBytesRead) / Float(totalBytesExpectedToRead))
                if downloadType == .SEQUENTIAL {
                    firstArrayObject.progressValue(percentage: percentage)
                    self.progress = firstArrayObject.progressValue
                } else {
                    progressValue(percentage: percentage)
                }
        }
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        obj.req?.requestTAG = apiTag
        obj.req?.requestTime = "\(currentTime)"
        
        if downloadType == .PARALLEL {
            obj.parallelDownloadRequest.addObject(obj.req!)
        } else {
            firstArrayObject.isRunning = true
            firstArrayObject.requestObj = obj.req
            firstArrayObject.apiTime = "\(currentTime)"
            firstArrayObject.apiTag = apiTag
        }
        
        obj.req?.response(completionHandler: {  _,response, _, error in
            
            let requestTag =  self.req?.requestTAG
            
            if downloadType == .SEQUENTIAL {
                let matchingObjects = TSGHelper.sharedInstance.sequentialDownloadRequest.filter({return ($0 as! RequestModel).apiTag == requestTag})
                
                for object in matchingObjects {
                    for serialObj in self.sequentialDownloadRequest {
                        if (object as! RequestModel).apiTime == (serialObj as! RequestModel).apiTime{
                            self.sequentialDownloadRequest.removeObject(object)
                        }
                    }
                }
                
                self.hitAnotherDownloadRequest({ (percentage) in
                    progressValue(percentage: percentage)
                    }, success: { (response) in
                        success(response: localPath!)
                    }, failure: { (error) in
                        failure(error)
                })
                
            }
            else {
                let matchingObjects = TSGHelper.sharedInstance.parallelDownloadRequest.filter({return ($0 as! Request).requestTAG == requestTag})
                self.parallelDownloadRequest.removeObject(matchingObjects)
                
                for object in matchingObjects {
                    for parallelObj in self.parallelDownloadRequest {
                        if (object as! Request).requestTAG == (parallelObj as! Request).requestTAG{
                            self.parallelDownloadRequest.removeObject(object)
                        }
                    }
                }
            }
            
            if response != nil {
                if downloadType == .SEQUENTIAL {
                    if localPath == nil {
                        failure(error!)
                    }else {
                    firstArrayObject.successBlock(response: localPath!)
                    self.success = firstArrayObject.successBlock
                    }
                }
                else {
                    if localPath == nil {
                        failure(error!)
                    }else {
                    success(response: localPath!)
                    }
                }
            }
            if error != nil {
                if downloadType == .SEQUENTIAL {
                    firstArrayObject.failureBlock(error: error!)
                    self.failure = firstArrayObject.failureBlock
                }
                else {
                    failure(error!)
                }
            }
            
        })
        
    }
    
    /**
     Resume any pending downloads
     - paramter url: Resume download url
     - parameter success: Block to handle response
     */
    public class func resumeDownloads(path:String, withApiTag apiTag:String?=nil,success:(Int64,totalBytes:Int64)-> Void)
    {
        let obj = TSGHelper.sharedInstance
        
        obj.serviceCount = obj.serviceCount + 1
        
        var actionID:String!
        
        if apiTag != nil {
            actionID = apiTag
        } else {
            actionID = "ResumeDownload"
        }
        
        let completeURL = TSGHelper.sharedInstance.baseUrl + path
        
        let destination = Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        obj.req =  obj.manager.download(.GET, completeURL, destination: destination)
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                success(totalBytesRead,totalBytes:totalBytesExpectedToRead)
        }
        
        obj.req?.requestTAG = apiTag!
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        let failureBlock:(error:NSError)->()? = {error in return}
        let progressValue:(percentage:Float)->()? = { percent in return}
        let successBlock:(response:AnyObject)->()? = {success in return}
        
        
        progressValue(percentage: 1.0)
        
        
        obj.sequentialDownloadRequest.addObject(RequestModel(url: path, type: RequestType.GET, state: true, apiTag: actionID, priority: true, actionType: .DOWNLOAD, apiTime: "\(currentTime)", progressBlock: progressValue, successBlock: successBlock, failureBlock: failureBlock))
        
        
        obj.req!.response { _, _, _, _ in
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

    internal func hitAnotherDownloadRequest(progressValue:(percentage:Float)->(),success:(response:AnyObject)->(),failure:(NSError)->()){
        
        if TSGHelper.sharedInstance.sequentialDownloadRequest.count > 0 {
            let requestObj:RequestModel = sequentialDownloadRequest[0] as! RequestModel
            self.download(requestObj.url,requestType:requestObj.type,downloadType:.SEQUENTIAL, withApiTag: requestObj.apiTag, progressValue: { (percentage) in
                progressValue(percentage: percentage)
                }, success: { (response) in
                    success(response: response)
                }, failure: { (error) in
                    failure(error)
            })
        }
    }
    
  
}