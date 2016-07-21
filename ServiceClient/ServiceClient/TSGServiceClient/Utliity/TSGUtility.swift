//
//  TSGUtility.swift
//  TSGServiceClient
//
//  Created by Ayush on 6/13/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit

class TSGUtility: NSObject {
    var tsgErrorManger:TSGErrorManager? = TSGErrorManager()
    
    internal class func returnMimeType(mimeType:MimeType) -> String {
        
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
    
    
    internal class func changeImageResolution(imageData:NSData, withImageQuality imageQuality:ImageQuality)-> NSData {
        
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
        if imgData == nil {
            return imageData
        }
        return imgData
    }
    
    
    internal class func createPathParamURL (tempURL:String, pathParamDict:[String:AnyObject]!, setString:(completeString:String?)->(), error:(String)->()){
        
        var resultantString:String!
        var pathParamString = tempURL
        while pathParamString.containsString("{") {
            
            let status = tempURL.rangeOfString("{")
            let startIndex: Int = tempURL.startIndex.distanceTo(status!.endIndex)
            let endRange = tempURL.rangeOfString("}")
            let endIndex: Int = tempURL.startIndex.distanceTo(endRange!.startIndex)
            
            let range = tempURL.startIndex.advancedBy(startIndex) ..< tempURL.startIndex.advancedBy(endIndex)
            resultantString = tempURL.substringWithRange(range)
            
            if pathParamDict[resultantString] == nil{
                setString(completeString: nil)
                error("\(resultantString): Required key is missing")
                 break
            }else {
                pathParamString = pathParamString.stringByReplacingOccurrencesOfString("{\(resultantString)}", withString: "\(pathParamDict[resultantString]!)")
                setString(completeString: pathParamString)
                
            }
        }
        
    }
}

