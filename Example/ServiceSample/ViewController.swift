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
        
        let optionMenu = UIAlertController(title: nil, message: "Select http actions", preferredStyle: .ActionSheet)
        
        let setProjectId = UIAlertAction(title: "Set ProjectID", style: .Default) { (alert:UIAlertAction) in
            self.setProjecRunningID()
        }
        
        let hitAnyRequest = UIAlertAction(title: "Any Request", style: .Default) { (alert:UIAlertAction) in
            self.anyRequest()
        }
        let getRequest = UIAlertAction(title: "GET Request", style: .Default) { (alert: UIAlertAction) in
            self.getRequest()
        }
        
        let pathParamRequest = UIAlertAction(title: "PathParam Request", style: .Default) { (alert: UIAlertAction) in
            self.pathParamRequest()
        }
        let postRequest = UIAlertAction(title: "POST Request", style: .Default) { (alert: UIAlertAction) in
            self.postRequest()
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
        }
        
        let cancelRequest = UIAlertAction(title: "Cancel", style: .Default) { (alert:UIAlertAction) in
            
        }
        
        optionMenu.addAction(setProjectId)
        optionMenu.addAction(hitAnyRequest)
        optionMenu.addAction(getRequest)
        optionMenu.addAction(pathParamRequest)
        optionMenu.addAction(postRequest)
        optionMenu.addAction(putRequest)
        optionMenu.addAction(uploadRequest)
        optionMenu.addAction(downloadRequest)
        optionMenu.addAction(deleteRequest)
        optionMenu.addAction(cancelRequest)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)

    }
  
    func pathParamRequest(){
        let pathParamDict:NSMutableDictionary = NSMutableDictionary()
        pathParamDict.setValue("4", forKey: "user-id")
        
        //TSGServiceManager.setProjectRuningMode(.DUMMY)
        TSGServiceManager.performAction("5759249a62c18b953cf00e7f",withPathParams: pathParamDict, onSuccess: { (object) in
            print(object)
            }) { (status, error) in
                print(error)
        }
    }
    
    func anyRequest(){
        ServiceManager.setBaseURL("http://172.16.144.218:4000/")
        ServiceManager.hitRequestForAPI("projects/all_projects",typeOfRequest: .GET, typeOFResponse: .JSON, withApiTag: "Hit", success: { (object) in
            print(object)
            self.apiResult.text = "SUCCESS: Any-request executed successfully"

            }) { (error) in
                print(error)
        }
    }
    
    func downloadRequest() {
        //http://www.charts.noaa.gov/BookletChart/
        activityIndicatorView.hidden = false
        activityIndicatorView.startAnimating()
        
        progressIndicator.hidden = false

        ServiceManager.setBaseURL("http://jplayer.org/video/m4v/")

        ServiceManager.downloadWith("Big_Buck_Bunny_Trailer.m4v", requestType: .GET, progress: { (percentage) in
            
            dispatch_async(dispatch_get_main_queue()) {
                self.progressIndicator.setProgress(percentage, animated: true)
            }

            }, success: { (response) in
                self.activityIndicatorView.hidden = true
               // self.progressView.hidden = true
                self.apiResult.hidden = false
                self.apiResult.text = "SUCCESS: Image Downloaded"
            }) { (error) in
                print(error)
        }
        
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
        TSGServiceManager.setProjectRuningMode(.DEVELOPMENT)
    }
    
    //MARK : function for Get Request
    func getRequest() {
    
        TSGServiceManager.performAction("5745591afec9101a0a63f23d", onSuccess: { ( dictionary) in
            print("\(dictionary)")
            self.apiResult.text = "Success: GET request executed successfully"
            
        }) { (bool, errors) in
            print("\(bool,errors)")
        }
    }
    
    //MARK : function for Post Request
    func postRequest() {
        
        let bodyDict = ["user_email":"yogesh@gmail.com", "name":"yogesh"]

        
        TSGServiceManager.performAction("5746a52e91eac6291f8b15fd", withParams: bodyDict, onSuccess: { ( dictionary) in
            print("\(dictionary)")

            self.apiResult.text = "SUCCESS: POST request executed successfully"
        }) { (bool, errors) in
            let temp = self.convertDictToJSONString(errors.userInfo)
            self.apiResult.text = temp

        }
    }
    
    //MARK : function for Put Request
    func putRequest() {
        
        let bodyDict = ["project_id":"55", "name":"yogesh","user_email":"yogesh@gmail.com","age":"32"]
        
        
        TSGServiceManager.performAction("5742a28c5262ef7a1aae2977", withParams:bodyDict, onSuccess: { (dictionary) in
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
        
        
        TSGServiceManager.performAction("5742a2b95262ef7a1aae297d", withParams: keydict, onSuccess: { (dictionary) in
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
        
        TSGServiceManager.uploadData("5742a30b5262ef7a1aae2980", mimeType: MimeType.PNG_IMAGE, bodyParams: bodyDict,dataKeyName:"avatar", imageQuality: ImageQuality.LOW, progress: { (percentage) in
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
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}


