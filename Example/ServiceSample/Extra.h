//
//  Extra.h
//  ServiceSample
//
//  Created by Yogesh Bhatt on 23/08/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

/***** SEQUENTIAL ********/

//        ServiceManager.downloadWith("Incredibles_Teaser.m4v",requestType: .GET, downloadType: .SEQUENTIAL, withApiTag: "CCCCCC", prority: false, progress: { (percentage) in
//            print("CCCCCC\(percentage)")
//            dispatch_async(dispatch_get_main_queue()) {
//                self.progressIndicator.setProgress(percentage, animated: true)
//            }
//            }, success: { (response) in
//                print("CCCCCC\(response)")
//        }) { (error) in
//            print(error)
//        }
//
//        ServiceManager.downloadWith("Incredibles_Teaser_320x144_h264aac.m4v",requestType: .GET, downloadType: .PARALLEL, withApiTag: "DDDDDD", prority: false, progress: { (percentage) in
//            print("DDDDDD\(percentage)")
//            dispatch_async(dispatch_get_main_queue()) {
//                self.progressIndicator.setProgress(percentage, animated: true)
//            }
//            }, success: { (response) in
//                print("DDDDDD\(response)")
//        }) { (error) in
//            print(error)
//        }
//
//        ServiceManager.downloadWith("Incredibles_Teaser_640x272_h264aac.m4v",requestType: .GET, downloadType: .SEQUENTIAL, withApiTag: "EEEEEE", prority: true, progress: { (percentage) in
//            print("EEEEEE\(percentage)")
//            dispatch_async(dispatch_get_main_queue()) {
//                self.progressIndicator.setProgress(percentage, animated: true)
//            }
//            }, success: { (response) in
//                print("EEEEEE\(response)")
//        }) { (error) in
//            print(error)
//        }


//        TSGServiceManager.uploadData(IMAGEUPLOAD, mimeType: MimeType.PNG_IMAGE, bodyParams: bodyDict,dataKeyName:"avatar", imageQuality: ImageQuality.LOW,uploadType:.SEQUENTIAL,prority:true, progress: { (percentage) in
//            print("aaaa \(percentage)")
//
//            dispatch_async(dispatch_get_main_queue()) {
//                self.progressIndicator.setProgress(percentage, animated: true)
//            }
//        }, success: { (response) in
//            self.activityIndicatorView.hidden = true
//           self.progressIndicator.hidden = true
//            self.apiResult.hidden = false
//            self.apiResult.text = "SUCCESS: Image Uploaded"
//        }) { (error) in
//            print("Some error")

//  }

// let bodyDict1 = ["name":"Ashish","user_email":"Ashish@kiwitech.com","age":"23","avatar":imageData! as NSData]

//        TSGServiceManager.uploadData(IMAGEUPLOAD, mimeType: MimeType.PNG_IMAGE, bodyParams: bodyDict1,dataKeyName:"avatar", imageQuality: ImageQuality.LOW,uploadType:.SEQUENTIAL,prority:false, progress: { (percentage) in
//            print("bbbb \(percentage)")
//
//            dispatch_async(dispatch_get_main_queue()) {
//                self.progressIndicator.setProgress(percentage, animated: true)
//            }
//            }, success: { (response) in
//                self.activityIndicatorView.hidden = true
//                self.progressIndicator.hidden = true
//                self.apiResult.hidden = false
//                self.apiResult.text = "SUCCESS: Image Uploaded"
//        }) { (error) in
//            print("Some error")
//
//        }

/***** SEQUENTIAL ********/


//        TSGServiceManager.uploadData(IMAGEUPLOAD, mimeType: MimeType.PNG_IMAGE, bodyParams: bodyDict,dataKeyName:"avatar", imageQuality: ImageQuality.LOW,uploadType:.SEQUENTIAL,prority:false, progress: { (percentage) in
//            print("ccccc \(percentage)")
//            dispatch_async(dispatch_get_main_queue()) {
//                self.progressIndicator.setProgress(percentage, animated: true)
//            }
//            }, success: { (response) in
//                self.activityIndicatorView.hidden = true
//                self.progressIndicator.hidden = true
//                self.apiResult.hidden = false
//                self.apiResult.text = "SUCCESS: Image Uploaded"
//        }) { (error) in
//            print("Some error")
//
//        }
//        TSGServiceManager.uploadData(IMAGEUPLOAD, mimeType: MimeType.PNG_IMAGE, bodyParams: bodyDict,dataKeyName:"avatar", imageQuality: ImageQuality.LOW,uploadType:.SEQUENTIAL,prority:false, progress: { (percentage) in
//            print("dddd \(percentage)")
//            dispatch_async(dispatch_get_main_queue()) {
//                self.progressIndicator.setProgress(percentage, animated: true)
//            }
//            }, success: { (response) in
//                self.activityIndicatorView.hidden = true
//                self.progressIndicator.hidden = true
//                self.apiResult.hidden = false
//                self.apiResult.text = "SUCCESS: Image Uploaded"
//        }) { (error) in
//            print("Some error")
//
//        }
//
//        TSGServiceManager.uploadData(IMAGEUPLOAD, mimeType: MimeType.PNG_IMAGE, bodyParams: bodyDict,dataKeyName:"avatar", imageQuality: ImageQuality.LOW,uploadType:.SEQUENTIAL,prority:false, progress: { (percentage) in
//            print("eeeee \(percentage)")
//            dispatch_async(dispatch_get_main_queue()) {
//                self.progressIndicator.setProgress(percentage, animated: true)
//            }
//            }, success: { (response) in
//                self.activityIndicatorView.hidden = true
//                self.progressIndicator.hidden = true
//                self.apiResult.hidden = false
//                self.apiResult.text = "SUCCESS: Image Uploaded"
//        }) { (error) in
//            print("Some error")
//
//        }
