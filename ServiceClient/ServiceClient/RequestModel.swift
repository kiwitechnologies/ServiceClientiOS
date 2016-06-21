//
//  RequestModel.swift
//  TSGServiceClient
//
//  Created by Yogesh Bhatt on 15/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//


import Foundation

class RequestModel:NSObject {
    
    var url:String!
    var bodyParam:NSDictionary?=nil
    var queryParam:NSDictionary?=nil
    var type:RequestType
    var isRunning:Bool
    var apiTag:String!
    var priority:Bool
    var actionType:ActionType
    var apiTime:String
    var dataKeyName:String?
    var mimeType:MimeType?
    var imageQuality:ImageQuality?
    var progressValue:(percentage:Float)->()? //= { percent in}
    var successBlock:(response:AnyObject)->()? //= { response in}
    var failureBlock:(error:NSError)->()? //= { error in}
    var requestObj:Request?
    
    init(url:String!, bodyParam:NSDictionary?=nil,queryParam:NSDictionary?=nil, type:RequestType, state:Bool = false, apiTag:String!, priority:Bool,actionType:ActionType,apiTime:String,requestObj:Request?=nil,dataKeyName:String?=nil,mimeType:MimeType?=nil,imageQuality:ImageQuality?=nil,progressBlock:(percentage:Float)->()?,successBlock:(response:AnyObject)->()?,
         failureBlock:(error:NSError)->()?){
        
        self.url = url
        self.bodyParam = bodyParam
        self.type = type
        self.isRunning = state
        self.apiTag = apiTag
        self.priority = priority
        self.actionType = actionType
        self.queryParam = queryParam
        self.apiTime = apiTime
        self.dataKeyName = dataKeyName
        self.mimeType = mimeType
        self.imageQuality = imageQuality
        self.progressValue = progressBlock
        self.successBlock = successBlock
        self.failureBlock = failureBlock
        self.requestObj = requestObj
    }
}