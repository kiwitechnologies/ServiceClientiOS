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
    var param:NSDictionary?=nil
    var type:RequestType
    var isRunning:Bool
    var apiTag:String!
    
    init(url:String!, param:NSDictionary?=nil, type:RequestType, state:Bool = false, apiTag:String!){
        
        self.url = url
        self.param = param
        self.type = type
        self.isRunning = state
        self.apiTag = apiTag
    }
}