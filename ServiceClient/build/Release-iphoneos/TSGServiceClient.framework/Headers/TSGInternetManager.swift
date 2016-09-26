//
//  AlamofireManager.swift
//  Alamofire
//
//  Created by Ayush Goel on 26/10/15.
//  Copyright © 2015 Ayush Goel. All rights reserved.
//
//This class implements the Alamofire methods

import UIKit

public class TSGInternetManager: NSObject
{

    var networkStatus:NetworkStatus = .Unknown
      /*
     *Singleton method
     */
    public class var sharedInstance: TSGInternetManager
    {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: TSGInternetManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = TSGInternetManager()
        }
        return Static.instance!
    }

    
    public class func monitorNetworkStatus()
    {
        let net = NetworkReachabilityManager()
        net?.startListening()
        
        net?.listener = {status in
            
            if  net?.isReachable ?? false {
                
                if ((net?.isReachableOnEthernetOrWiFi) != nil) {
                     TSGInternetManager.sharedInstance.networkStatus = .EthernetOrWiFi

                }else if(net?.isReachableOnWWAN)! {
                     TSGInternetManager.sharedInstance.networkStatus = .WWAN
                }
            }
            else {
                 TSGInternetManager.sharedInstance.networkStatus = .NotReachable
                print("no connection")
            }
            
        }
    }
    
    public class func isInternetAvailable() -> Bool
    {
        if( TSGInternetManager.sharedInstance.networkStatus == .EthernetOrWiFi || TSGInternetManager.sharedInstance.networkStatus == .WWAN)
        {
            return true
        }

        return false

    }

}
