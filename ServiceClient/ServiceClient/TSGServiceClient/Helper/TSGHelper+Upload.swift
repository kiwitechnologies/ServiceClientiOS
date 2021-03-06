//
//  TSGHelper+Upload.swift
//  TSGServiceClient
//
//  Created by Yogesh Bhatt on 20/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation

extension TSGHelper {
    
    //MARK: A webtool method to upload file
    
    public class func uploadFileWith(actionName: String,bodyParams:NSDictionary, dataKeyName:String,mimeType:MimeType,imageQuality:ImageQuality?=ImageQuality.HIGH, withApiTag apiTag:String?=nil,uploadType:UploadType = UploadType.PARALLEL,priority:Bool,requestType:RequestType, progress: (percent: Float) -> Void, success:(response:AnyObject) -> Void, failure:ErrorType->Void)
    {
        let obj = TSGHelper.sharedInstance
        let imageData = TSGUtility.changeImageResolution(bodyParams.valueForKey(dataKeyName) as! NSData, withImageQuality: imageQuality!)
        
        let dictParams = NSMutableDictionary(dictionary:bodyParams)
        dictParams.removeObjectForKey(dataKeyName)
        
        TSGValidationManager.validateActionData(actionName, withBodyParam: bodyParams,withHeaderDic: TSGHelper.sharedInstance.apiHeaderDict, withOptionalData:imageData , onSuccess: { (object, str) in
            
            var completeURL:String!
            
            if TSGHelper.sharedInstance.appRuningMode == .DEVELOPMENT  {
                completeURL = (object as! TSGAPI).dev_baseURL! + (object as! TSGAPI).actionName!
            } else if TSGHelper.sharedInstance.appRuningMode == .TESTING {
                completeURL = (object as! TSGAPI).qa_baseURL! + (object as! TSGAPI).actionName!
                
            } else if TSGHelper.sharedInstance.appRuningMode == .STAGING {
                completeURL = (object as! TSGAPI).stage_baseURL! + (object as! TSGAPI).actionName!
                
            } else if TSGHelper.sharedInstance.appRuningMode == .PRODUCTION {
                completeURL = (object as! TSGAPI).prod_baseURL! + (object as! TSGAPI).actionName!
            }
            else if TSGHelper.sharedInstance.appRuningMode == .DUMMY {
                completeURL = (object as! TSGAPI).dummy_server_URL!
            }
            
            var actionID:String!
            
            if apiTag == nil {
                actionID = "Upload"
            } else {
                actionID = apiTag
            }
            
            if uploadType == .SEQUENTIAL {
                
                let currentTime = NSDate.timeIntervalSinceReferenceDate()
                if priority == true {
                    obj.sequentialUploadRequest.insertObject(RequestModel(url: completeURL,bodyParam:bodyParams , type: requestType, apiTag: actionID, priority: priority, actionType: .UPLOAD, apiTime: "\(currentTime)",dataKeyName:dataKeyName, mimeType:mimeType,imageQuality:imageQuality, progressBlock: progress, successBlock: success, failureBlock: failure), atIndex: 0)
                } else {
                    obj.sequentialUploadRequest.addObject(RequestModel(url: completeURL,bodyParam: bodyParams, type: requestType, apiTag: actionID, priority: priority, actionType: .UPLOAD, apiTime: "\(currentTime)",dataKeyName:dataKeyName,mimeType:mimeType,imageQuality:imageQuality, progressBlock: progress, successBlock: success, failureBlock: failure))
                }
                
                if obj.sequentialUploadRequest.count == 1 {
                    
                    obj.uploadFile(completeURL, bodyParams: bodyParams, dataKeyName: dataKeyName, mimeType: mimeType,imageQuality:imageQuality, withApiTag: actionID,uploadType:uploadType,requestType:requestType,priority: priority, progress: { (percent) in
                        progress(percent: percent)
                        }, success: { (response) in
                            success(response: response)
                    }) { (error) in
                        failure(error)
                    }
                }else {
                    let firstArrayObject:RequestModel = obj.sequentialUploadRequest[0] as! RequestModel
                    
                    if firstArrayObject.isRunning == true {
                        obj.uploadFile(completeURL, bodyParams: bodyParams, dataKeyName: dataKeyName, mimeType: mimeType,imageQuality:imageQuality, withApiTag: actionID,uploadType:uploadType,requestType:requestType,priority: priority, progress: { (percent) in
                            progress(percent: percent)
                            }, success: { (response) in
                                success(response: response)
                        }) { (error) in
                            failure(error)
                        }
                        
                    }
                }
                
            } else {
                
                TSGHelper.sharedInstance.uploadFile(completeURL, bodyParams: bodyParams, dataKeyName: dataKeyName, mimeType: mimeType,imageQuality: imageQuality, withApiTag:actionID,uploadType: uploadType,requestType:requestType,priority: priority,  progress: { (percent) in
                    progress(percent: percent)
                    }, success: { (response) in
                        success(response: response)
                    }, failure: { (error) in
                        failure(error)
                })
            }
            
            
            
        }) { (error) in
            print(error)
        }
        
    }
    

    //MARK: A common method to upload data
    
    public class func uploadWith(path: String,bodyParams:NSDictionary, dataKeyName:String,mimeType:MimeType,imageQuality:ImageQuality?=ImageQuality.HIGH, withApiTag apiTag:String?=nil,uploadType:UploadType = UploadType.PARALLEL,requestType:RequestType,priority:Bool = false, progress: (percent: Float) -> Void, success:(response:AnyObject) -> Void, failure:ErrorType->Void)
    {
        let obj = TSGHelper.sharedInstance
        
        let dictParams = NSMutableDictionary(dictionary:bodyParams)
        dictParams.removeObjectForKey(dataKeyName)
        
        var completeURL:String!
        
        if TSGHelper.sharedInstance.baseUrl != nil {
            completeURL = TSGHelper.sharedInstance.baseUrl + path
        }
        else {
            completeURL = path
        }
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        var objID:String!
        
        if apiTag == nil {
            objID = "Upload"
        } else {
            objID = apiTag
        }
        
        if uploadType == .SEQUENTIAL {
            if priority == true {
                obj.sequentialUploadRequest.insertObject(RequestModel(url: path, type: .POST, apiTag: objID, priority: priority, actionType: .UPLOAD, apiTime: "\(currentTime)",dataKeyName:dataKeyName, mimeType:mimeType,imageQuality:imageQuality, progressBlock: progress, successBlock: success, failureBlock: failure), atIndex: 0)
            }else {
                obj.sequentialUploadRequest.addObject(RequestModel(url: path, type: .POST, apiTag: objID, priority: priority, actionType: .UPLOAD, apiTime: "\(currentTime)",dataKeyName:dataKeyName, mimeType:mimeType,imageQuality:imageQuality, progressBlock: progress, successBlock: success, failureBlock: failure))
            }
            
            if obj.sequentialUploadRequest.count == 1 {
                obj.uploadFile(completeURL, bodyParams: bodyParams, dataKeyName: dataKeyName, mimeType: mimeType,imageQuality:imageQuality, withApiTag: objID,uploadType:uploadType,requestType:requestType,priority: priority, progress: { (percent) in
                    progress(percent: percent)
                    }, success: { (response) in
                        success(response: response)
                }) { (error) in
                    failure(error)
                }
                
                
            } else {
                let firstArrayObject:RequestModel = obj.sequentialUploadRequest[0] as! RequestModel
                
                if firstArrayObject.isRunning == false {
                    obj.uploadFile(completeURL, bodyParams: bodyParams, dataKeyName: dataKeyName, mimeType: mimeType,imageQuality:imageQuality, withApiTag: objID,uploadType:uploadType,requestType:requestType,priority: priority, progress: { (percent) in
                        progress(percent: percent)
                        }, success: { (response) in
                            success(response: response)
                    }) { (error) in
                        failure(error)
                    }
                    
                }
            }
            
        }
        else {
            
            obj.uploadFile(completeURL, bodyParams: bodyParams, dataKeyName: dataKeyName, mimeType: mimeType,imageQuality:imageQuality, withApiTag: objID,uploadType:uploadType,requestType:requestType,priority: priority, progress: { (percent) in
                progress(percent: percent)
                }, success: { (response) in
                    success(response: response)
            }) { (error) in
                failure(error)
            }
        }
    }

    //MARK: Internal method to upload file
    internal func uploadFile(completeURL:String,bodyParams:NSDictionary, dataKeyName:String,mimeType:MimeType,imageQuality:ImageQuality?=ImageQuality.HIGH, withApiTag apiTag:String,uploadType:UploadType = UploadType.PARALLEL,requestType:RequestType,priority:Bool, progress: (percent: Float) -> Void?,success:(response:AnyObject) -> Void?, failure:NSError->Void?){
        
        let obj = TSGHelper.sharedInstance
        let imageData = TSGUtility.changeImageResolution(bodyParams.valueForKey(dataKeyName) as! NSData, withImageQuality: imageQuality!)
        let dictParams = NSMutableDictionary(dictionary:bodyParams)
        dictParams.removeObjectForKey(dataKeyName)
        
        let mimeType:String = TSGUtility.returnMimeType(mimeType)
        self.success = success
        self.progress = progress
        self.failure = failure
        
        var currentAPITime:String!
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        currentAPITime = "\(currentTime)"
        
        var firstArrayObject:RequestModel!
        
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
        

        
        if uploadType == .SEQUENTIAL {
            firstArrayObject = obj.sequentialUploadRequest[0] as! RequestModel
        }
        

      //AYUSH requestTAG:apiTag, apiTime:currentAPITime,
        
        obj.manager.upload(
            requestMethod,
            completeURL,
            requestTAG:apiTag,
            apiTime:currentAPITime,
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
                    if uploadType == .SEQUENTIAL {
                        firstArrayObject.requestObj = upload
                        firstArrayObject.isRunning = true
                        firstArrayObject.apiTime = currentAPITime
                        firstArrayObject.apiTag = apiTag
                    } else {
                        obj.parallelUploadRequest.addObject(upload)
                    }
                    
                    upload.progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                        dispatch_async(dispatch_get_main_queue()) {
                            let percent = (Float(totalBytesWritten) / Float(totalBytesExpectedToWrite))
                            if uploadType == .SEQUENTIAL {
                                firstArrayObject.progressValue(percentage: percent)
                                self.progress = firstArrayObject.progressValue
                            }else {
                                progress(percent: percent)
                                
                            }
                        }
                    }
                    upload.responseJSON(completionHandler: { (response) in
                        if uploadType == .SEQUENTIAL {

                            let matchingObjects = TSGHelper.sharedInstance.sequentialUploadRequest.filter({
                                return ($0 as! RequestModel).apiTag == upload.requestTAG})
                            
                            for object in matchingObjects {
                                for parallelObj in self.sequentialUploadRequest {
                                    if (object as! RequestModel).apiTime == upload.requestTime{
                                        
                                        self.sequentialUploadRequest.removeObject(object)
                                    }
                                }
                            }
                            
                        } else {
                            let matchingObjects = TSGHelper.sharedInstance.parallelUploadRequest.filter({return ($0 as! Request).requestTAG == upload.requestTAG})
                            self.parallelUploadRequest.removeObject(matchingObjects)
                            
                            for object in matchingObjects {
                                for parallelObj in self.parallelUploadRequest {
                                    if (object as! Request).requestTime == (parallelObj as! Request).requestTime{
                                        self.parallelUploadRequest.removeObject(object)
                                    }
                                }
                            }
                            
                        }
                        
                        
                        dispatch_async(dispatch_get_main_queue(),
                            {
                                obj.serviceCount = obj.serviceCount - 1
                                
                                if response.response?.statusCode <= 200 {
                                    if response.result.value != nil {
                                        
                                        if uploadType == .SEQUENTIAL {
                                            firstArrayObject.successBlock(response: response.result.value!)
                                            self.success = firstArrayObject.successBlock
                                        } else {
                                            success(response: response.result.value!)
                                            
                                        }
                                    } else {
                                        failure(response.result.error!)
                                    }
                                    if uploadType == .SEQUENTIAL {
                                        self.hitAnotherSequentialUploadRequest(requestType,progressValue: { (percentage) in
                                            progress(percent: percentage)
                                            }, success: { (response) in
                                                success(response: response)
                                            }, failure: { (error) in
                                                failure(error)
                                        })
                                    }
                                   
                                } else {
                                    if response.result.error != nil {
                                        if uploadType == .SEQUENTIAL {
                                            firstArrayObject.failureBlock(error: response.result.error!)
                                            self.failure = firstArrayObject.failureBlock
                                        }else {
                                            failure(response.result.error!)
                                        }
                                          if uploadType == .SEQUENTIAL {
                                        self.hitAnotherSequentialUploadRequest(requestType,progressValue: { (percentage) in
                                            progress(percent: percentage)
                                            }, success: { (response) in
                                                success(response: response)
                                            }, failure: { (error) in
                                                failure(error)
                                        })}
}
                                }
                        })
                    })
                    
                case .Failure(let encodingError):
                    print("Encoding error------------------------\(encodingError)")
                }
            }
        )
    }

    func hitAnotherSequentialUploadRequest(requestType:RequestType,progressValue:(percentage:Float)->(),success:(response:AnyObject)->(),failure:(NSError)->()){
        
        if TSGHelper.sharedInstance.sequentialUploadRequest.count > 0 {

            let requestObj:RequestModel = sequentialUploadRequest[0] as! RequestModel
               requestObj.isRunning = true
            
            self.uploadFile(requestObj.url, bodyParams: requestObj.bodyParam!, dataKeyName: requestObj.dataKeyName!, mimeType: requestObj.mimeType!,imageQuality: requestObj.imageQuality, withApiTag: requestObj.apiTag, uploadType:.SEQUENTIAL,requestType:requestType, priority: requestObj.priority, progress: { (percent) -> Void? in
                progressValue(percentage: percent)
                }, success: { (response) -> Void? in
                    success(response: response)
                }, failure: { (error) -> Void? in
                    failure(error)
            })
        }

    }
}
