//
//  TSGHelper+Cancel.swift
//  TSGServiceClient
//
//  Created by Yogesh Bhatt on 20/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation

extension TSGHelper {
    
    /**
     Cancel any ongoing alamofire operation
     */
    
    public class func cancelAllRequests()
    {
        let obj = TSGHelper.sharedInstance
        
        for requestObj in obj.sequentialDownloadRequest {
            if (requestObj as! RequestModel).requestObj != nil {
                let req = (requestObj as! RequestModel).requestObj
                req?.cancel()
            }
            obj.sequentialDownloadRequest.removeObject(requestObj)
        }
        
        for requestObj in obj.sequentialUploadRequest {
            if (requestObj as! RequestModel).requestObj != nil {
                let req = (requestObj as! RequestModel).requestObj
                req?.cancel()
            }
            obj.sequentialUploadRequest.removeObject(requestObj)
        }
        
        for request in obj.parallelDownloadRequest {
            (request as! Request).cancel()
            obj.parallelDownloadRequest.removeObject(request)
        }
        
        for request in obj.parallelUploadRequest {
            (request as! Request).cancel()
            obj.parallelUploadRequest.removeObject(request)
        }
        
        for request in obj.normalActionRequest {
            if (request as! RequestModel).requestObj != nil {
                let req = (request as! RequestModel).requestObj
                req?.cancel()
            }
            obj.normalActionRequest.removeObject(request)
        }
    }
    
    /**
     Cancel request With TagID
     */
    
    public class func cancelRequestWithTag(apiTag:String)
    {
        let obj = TSGHelper.sharedInstance
        
        print("dfdfdsfdsfdsfdsfdsfds")
        for requestObj in obj.sequentialDownloadRequest {
            if (requestObj as! RequestModel).apiTag == apiTag {
                print("dfdfdsfdsfdsfdsfdsfds")

                let req = (requestObj as! RequestModel).requestObj
                req?.cancel()
                obj.sequentialDownloadRequest.removeObject(requestObj)
                break
            }
        }
        
        for requestObj in obj.sequentialUploadRequest {

            if (requestObj as! RequestModel).apiTag == apiTag {
                let req = (requestObj as! RequestModel).requestObj
                req?.cancel()
                obj.sequentialUploadRequest.removeObject(requestObj)
                break
            }
        }
        
        for requestObj in obj.parallelDownloadRequest {

            if (requestObj as! Request).requestTAG == apiTag {
                (requestObj as! Request).cancel()
                obj.parallelDownloadRequest.removeObject(requestObj)
                break
            }
        }
        
        for requestObj in obj.parallelUploadRequest {

            if (requestObj as! Request).requestTAG == apiTag {
                (requestObj as! Request).cancel()
                obj.parallelUploadRequest.removeObject(requestObj)
                break
            }
        }
        
        for requestObj in obj.normalActionRequest {

            if (requestObj as! RequestModel).apiTag == apiTag {
                let req = (requestObj as! RequestModel).requestObj
                req?.cancel()
                obj.normalActionRequest.removeObject(requestObj)
               break
            }
        }
    }

}