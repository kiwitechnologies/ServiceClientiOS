//
//  ViewController.swift
//  LoginSample
//
//  Created by Yogesh Bhatt on 07/04/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit
import TSGServiceClient

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var apiResult: UITextView!
    @IBOutlet weak var progressIndicator: UIProgressView!
    @IBOutlet weak var plaintText: UITextField!
    @IBOutlet weak var cipherText: UILabel!
    @IBOutlet weak var decryptedText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var httpActionBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib
        activityIndicatorView.hidden = true
        httpActionBtn.layer.borderWidth = 1
        httpActionBtn.layer.cornerRadius = 5
        httpActionBtn.layer.borderColor = UIColor.blueColor().CGColor
    }
    
    @IBAction func btnActionClicked(sender: AnyObject)
    {
        
        let optionMenu = UIAlertController(title: nil, message: "ALLECTIVE ACTIONS", preferredStyle: .ActionSheet)
        
        let setProjectId = UIAlertAction(title: "Set ProjectID", style: .Default) { (alert:UIAlertAction) in
            self.setProjecRunningID()
        }
        
        let hitAnyRequest = UIAlertAction(title: "SESSION Request", style: .Default) { (alert:UIAlertAction) in
            self.sessionRequest()
        }
        let getRequest = UIAlertAction(title: "CATEGORIES Request", style: .Default) { (alert: UIAlertAction) in
            self.categoryRequest()
        }
        
        let postRequest = UIAlertAction(title: "RESET PASSWORD", style: .Default) { (alert: UIAlertAction) in
            self.resetRequest()
        }
        
        let downloadRequest = UIAlertAction(title: "Download Request", style: .Default) { (alert:UIAlertAction) in
            self.downloadRequest()
        }
        /*
        let pathParamRequest = UIAlertAction(title: "PathParam Request", style: .Default) { (alert: UIAlertAction) in
            self.pathParamRequest()
        }

        let putRequest = UIAlertAction(title: "PUT Request", style: .Default) { (alert:UIAlertAction) in
            self.putRequest()
        }
        
        let uploadRequest = UIAlertAction(title: "UPLOAD Request", style: .Default) { (alert:UIAlertAction) in
            self.uploadRequest()
        }
        
        let downloadRequest = UIAlertAction(title: "Download Request", style: .Default) { (alert:UIAlertAction) in
            self.downloadRequest()
        }
        
        let deleteRequest = UIAlertAction(title: "Delete Request", style: .Default) { (alert:UIAlertAction) in
            self.deleteRequest()
        } */
        
        let cancelRequest = UIAlertAction(title: "Cancel", style: .Default) { (alert:UIAlertAction) in
            
        }
        
        optionMenu.addAction(setProjectId)
        optionMenu.addAction(hitAnyRequest)
        optionMenu.addAction(getRequest)
        optionMenu.addAction(postRequest)
        optionMenu.addAction(downloadRequest)

       /* optionMenu.addAction(pathParamRequest)
        optionMenu.addAction(putRequest)
        optionMenu.addAction(uploadRequest)
        optionMenu.addAction(downloadRequest)
        optionMenu.addAction(deleteRequest)*/
        optionMenu.addAction(cancelRequest)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)

    }
  
    func pathParamRequest(){
        let pathParamDict:NSMutableDictionary = NSMutableDictionary()
        pathParamDict.setValue("4", forKey: "versfion_no")
        
        TSGServiceManager.performAction(RECENTMEDIA,withPathParams: pathParamDict, onSuccess: { (object) in
            print(object)
            }) { (status, error) in
                print(error)
        }
    }
    
    func sessionRequest()
    {
        TSGServiceManager.enableLog(true)
        TSGServiceManager.setEncoding(.URL)
        
        let jsonDict = ["user[email]":"manish.johari@kiwitech.com","user[code]":"9967"]

        TSGServiceManager.performAction(SESSION, withBodyParams: jsonDict, onSuccess: { (object) in
            print(object)
             self.apiResult.text = "\(object)"
            }) { (status, error) in
                print(error)
            self.apiResult.text = "\(error)"
        }
    }
    
    func downloadRequest()
    {
        //http://www.charts.noaa.gov/BookletChart/
        activityIndicatorView.hidden = false
        activityIndicatorView.startAnimating()
        
        progressIndicator.hidden = false

        ServiceManager.downloadWith("https://www.fi.edu/sites/default/files/styles/hero_medium/public/Hero_Home_Slider_Pixar_Sulley_9_0.jpg?itok=-zFEmbG",requestType: .GET, downloadType: .PARALLEL, withApiTag: "Picture 1", prority: false, progress: { (percentage) in
            print("Picture1 progress\(percentage)")
            dispatch_async(dispatch_get_main_queue()) {
                self.progressIndicator.setProgress(percentage, animated: true)
            }
            }, success: { (response) in
                print("Picture1 response \(response)")
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.activityIndicatorView.hidden = true
                    self.progressIndicator.hidden = true
                    self.apiResult.hidden = false
                    self.apiResult.text = "SUCCESS: File Downloaded"
                }

        }) { (error) in
            print(error)
        }
        
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

        
    }
    
    func uploadRequest() {
        
        self.apiResult.hidden = true
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        activityIndicatorView.hidden = false
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            picker.sourceType = .PhotoLibrary
            picker.modalPresentationStyle = .FullScreen
        }
        
        presentViewController(picker, animated: true, completion: nil)

        let paramDict:NSMutableDictionary! = NSMutableDictionary()
        paramDict.setObject("json", forKey: "format")
        
    }
    
    func setProjecRunningID()
    {
        TSGServiceManager.setResponseCode(300)
        TSGServiceManager.setProjectRuningMode(.DEVELOPMENT)
         let currentTime = NSDate.timeIntervalSinceReferenceDate()
         print(currentTime)
    }
    
    //MARK : function for Get Request
    func categoryRequest() {
    
        let bodyDict = ["auth_token":"fdssgfg gfgfgfdgfd"]

        
        TSGServiceManager.performAction(CATEGORIES, withQueryParam: bodyDict, onSuccess: { (object) in
            print(object)
            self.apiResult.text = "\(object)"

            }) { (status, error) in
                print(error)
                self.apiResult.text = "\(error)"

        }
    }
    
    //MARK : function for Post Request
    func resetRequest() {
        
        //let bodyDict = ["email":"manish.johari@kiwitech.com","code":"9967"]
        
     //   let dict = ["user":bodyDict]
        
        let bodyDict = ["user[email]":"manish.johari@kiwitech.com"]
        
        TSGServiceManager.performAction(RESETPASSWORD, withBodyParams: bodyDict, onSuccess: { ( dictionary) in
            print("\(dictionary)")

            self.apiResult.text = "\(dictionary)"
        }) { (bool, errors) in
            let temp = self.convertDictToJSONString(errors.userInfo)
            print(errors)
            self.apiResult.text = temp

        }
    }
    
    //MARK : function for Put Request
    func putRequest() {
        
        let bodyDict = ["project_id":"55", "name":"yogesh","user_email":"yogesh@gmail.com","age":"32"]
        
        
        TSGServiceManager.performAction(UPDATEPROJECT, withBodyParams:bodyDict, onSuccess: { (dictionary) in
          //  print("\(dictionary)")
            self.apiResult.text = "SUCCESS: PUT request executed successfully"
            
        }) { (bool, errors) in
            let temp = self.convertDictToJSONString(errors.userInfo)
            self.apiResult.text = temp
            print("\(bool,errors)")
        }

    }
    
    //MARK : function for Delete Request
    func deleteRequest() {
        
        let keydict = ["project_id":"56"]
        
        
        TSGServiceManager.performAction(DELETEPROJECT, withBodyParams: keydict, onSuccess: { (dictionary) in
            print("\(dictionary)")
            
        }) { (bool, errors) in
            print("\(bool,errors)")
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func convertDictToJSONString(dic:NSDictionary) -> String {
        
        do {
            let jsonData:NSData =  try NSJSONSerialization.dataWithJSONObject(dic, options: NSJSONWritingOptions.PrettyPrinted)
                return  NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
            
        } catch {
            
        }
       return "dfd"
    }

}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("Info did not have the required UIImage for the Original Image")
            dismissViewControllerAnimated(true, completion: nil)
            return
        }
        
        imageView.image = UIImage(named: "chand")
          let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        activityIndicatorView.startAnimating()
        progressIndicator.hidden = false
        progressIndicator.setProgress(0, animated: true)
        let bodyDict = ["name":"Ashish","user_email":"Ashish@kiwitech.com","age":"23","avatar":imageData! as NSData]
        
        TSGServiceManager.uploadData(IMAGEUPLOAD, mimeType: MimeType.PNG_IMAGE, bodyParams: bodyDict,dataKeyName:"avatar", imageQuality: ImageQuality.LOW,uploadType:.SEQUENTIAL,prority:true, progress: { (percentage) in
            print("aaaa \(percentage)")

            dispatch_async(dispatch_get_main_queue()) {
                self.progressIndicator.setProgress(percentage, animated: true)
            }
        }, success: { (response) in
            self.activityIndicatorView.hidden = true
           self.progressIndicator.hidden = true
            self.apiResult.hidden = false
            self.apiResult.text = "SUCCESS: Image Uploaded"
        }) { (error) in
            print("Some error")

        }
        
        let bodyDict1 = ["name":"Ashish","user_email":"Ashish@kiwitech.com","age":"23","avatar":imageData! as NSData]

        TSGServiceManager.uploadData(IMAGEUPLOAD, mimeType: MimeType.PNG_IMAGE, bodyParams: bodyDict1,dataKeyName:"avatar", imageQuality: ImageQuality.LOW,uploadType:.SEQUENTIAL,prority:false, progress: { (percentage) in
            print("bbbb \(percentage)")

            dispatch_async(dispatch_get_main_queue()) {
                self.progressIndicator.setProgress(percentage, animated: true)
            }
            }, success: { (response) in
                self.activityIndicatorView.hidden = true
                self.progressIndicator.hidden = true
                self.apiResult.hidden = false
                self.apiResult.text = "SUCCESS: Image Uploaded"
        }) { (error) in
            print("Some error")
            
        }
        
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

        dismissViewControllerAnimated(true, completion: nil)
    }
}


