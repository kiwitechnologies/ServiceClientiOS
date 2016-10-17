//
//  Enum.swift
//  ServiceClient
//
//  Created by Yogesh Bhatt on 26/04/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation

// Possible types of requests
public enum RequestType:String
{
    case GET
    case POST
    case PUT
    case DELETE
    
    static let allValues = [GET, POST, PUT,DELETE]
}

//Possible types of responses
public enum ResponseMethod:Int
{
    case JSON
    case RAW
    case DATA
}

public enum HttpRequestType:Int {
    
    case GET
    case POST
    case PUT
    case DELETE
    case HEAD
}

public enum ApiKeyValidationType:Int {
    
    case MIN_LENGTH
    case MAX_LENGTH
    case DATA_TYPE
}

public enum DataType:Int {
    
    case INTEGER
    case FLOAT
    case STRING
    case TEXT
    case FILE
}

public enum StingFormatType:Int {
    
    case ALPHA
    case NUMERIC
    case ALPHANUMERIC
    case EMAIL
}

public enum NetworkStatus:Int {
    
    case Unknown
    case NotReachable
    case EthernetOrWiFi
    case WWAN
}



public enum AppRuningModeType:Int {
    case PRODUCTION
    case STAGING
    case TESTING
    case DEVELOPMENT
    case DUMMY
}

public enum MimeType:Int {
    case PNG_IMAGE
    case JPEG_IMAGE
    case VIDEO
    case TEXT_FILE
    case PDF
}

public enum ImageQuality:Int {
    case HIGH
    case MEDIUM
    case LOW
}

public enum ParameterType:Int {
    case QUERY_PARAMETER
    case BODY_PARAMETER
}

public enum DownloadType:Int {
    case PARALLEL
    case SEQUENTIAL
    case NONE
}

public enum UploadType:Int {
    case PARALLEL
    case SEQUENTIAL
}

public enum ActionType:Int {
    case NORMAL
    case DOWNLOAD
    case UPLOAD
}
