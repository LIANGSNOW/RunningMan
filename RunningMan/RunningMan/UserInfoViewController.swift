//
//  UserInfoViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var account : UITextField!
    @IBOutlet weak var name : UITextField!
    @IBOutlet weak var gender : UITextField!
    @IBOutlet weak var age : UITextField!
    @IBOutlet weak var weight : UITextField!
    @IBOutlet weak var height : UITextField!
    
    @IBOutlet weak var userImage : UIImageView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.getUserInfoFromServer()
        self.account.text! = ApplicationSession.loginedUserId
    }
    
    func convertImageToBase64(image: UIImage) -> String {
        
        var imageData = UIImagePNGRepresentation(image)
        let base64String = imageData!.base64EncodedStringWithOptions(.EncodingEndLineWithCarriageReturn)
        return base64String
        
    }

    func convertBase64ToImage(base64String: String) -> UIImage {
        
        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0) )
        
        let decodedimage = UIImage(data: decodedData!)
        
        return decodedimage!
        
    }
    
    @IBAction func confirm(sender : AnyObject){
        
        var jsonData = ["account" : self.account.text!, "name" : self.name.text!, "sex" : self.gender.text!, "age" : self.age.text!]
        
        var dataString : NSString = ""
        
        if(self.userImage.image != nil){
            jsonData["img"] = convertImageToBase64(self.userImage.image!)
        } else {
            jsonData["img"] = ""
        }
        
        do{
            let data = try NSJSONSerialization.dataWithJSONObject(jsonData, options: [])
            dataString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        } catch{
            print("serialization json data error")
        }
        let start : String = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/userModify.action?userJson=" +
            "{\"account\":\"" + ApplicationSession.loginedUserId + "\","
        
        let anotherString : String =  "\"name\":\"" + jsonData["name"]! + "\","
        let anotherString1 : String = "\"age\":\"" + jsonData["age"]! + "\","
        let anotherString2 : String =  "\"sex\":\"" + jsonData["sex"]! + "\","
        let anotherString3 : String = "\"img\":\"" + jsonData["img"]! + "\"}"
        
        let url = start + anotherString + anotherString1 + anotherString2 + anotherString3

        NetworkTool.networkTool.urlRequest(url, function: modifyUserInfo, method: "POST")
    }

    func setUserInformation(result : String){
        let dictionary = NetworkTool.networkTool.convertStringToDictionary(result)
        
        self.name.text = (dictionary!["name"] as! String)
        self.gender.text = (dictionary!["sex"] as! String)
        self.age.text = (dictionary!["age"] as! String)
        if((dictionary!["img"] as! String) != ""){
            let base64String = dictionary!["img"] as! String
            
            self.userImage.image = self.convertBase64ToImage(base64String)
        }
    }

    
    func getUserInfoFromServer(){
        let url = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/viewUserByAccount.action?userAccount=\(ApplicationSession.loginedUserId)"
        NetworkTool.networkTool.urlRequest(url, function : setUserInformation)
    }
    
    func modifyUserInfo(result : String){
        
        switch result {
        case "INVALID_JSON_STR":
            AlertMessage.alertFunction("INVALID_JSON_STR error", uiViewController: self)
            break
        case "ACCOUNT_ALREADY_EXISTED":
            AlertMessage.alertFunction("The account already exists, please try another", uiViewController: self)
            break
        case "PWD_IS_NULL":
            AlertMessage.alertFunction("The password couldn't be null", uiViewController: self)
            break
        case "ERROR":
            AlertMessage.alertFunction("Unknown error", uiViewController: self)
            break
        case "SUCCESS":
            AlertMessage.alertFunction("Change Success!", uiViewController: self)
            break
        default:
            break
        }
        
    }
    
    @IBAction func selectTitleImage(sender : AnyObject){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        userImage.image = image
    }
    
    
    
    @IBAction func changePassword(sender : AnyObject){
        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("ChangePasswordViewController"))!, animated: true, completion: nil)
    }
    
    @IBAction func cancel(sender : AnyObject){
        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("TabBarController"))!, animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
