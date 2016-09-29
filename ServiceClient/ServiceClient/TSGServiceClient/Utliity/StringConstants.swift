//
//  StringConstants.swift
//  ServiceSample
//
//  Created by Yogesh Bhatt on 13/05/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation

let KEYS:String = "KEYS"
let MissingKeys:String = "MISSING_KEYS"
let INVALID_KEYS:String = "INVALID_KEYS"

let HEADERS:String = "HEADERS"
let Actions:String = "ACTIONS"

var errorStatus:[String:NSMutableArray]?

var missingParamKeys:[String:NSMutableArray]?
var missingInvalidParamKeys:[String:NSMutableArray]?

var missingHeaderKeys:[String:NSMutableArray]?
var missingHeaderParamKeys:[String:NSMutableArray]?


var invalidKeys:[String:NSMutableArray]? = [:]
var invalidHeaderKeys:[String:NSMutableArray]? = [:]


var alphaKey:NSMutableArray? = []
var alphaNumericKey:NSMutableArray? = []

var lengthKey:NSMutableArray? = []
var fileSizeKey:NSMutableArray? = []

var requiredKeys:NSMutableArray? = []
var emailKeys:NSMutableArray? = []

var numericKeys:NSMutableArray? = []
