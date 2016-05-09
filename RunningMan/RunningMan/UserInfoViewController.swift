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
    
    @IBAction func confirm(sender : AnyObject){
        
        if(self.userImage.image != nil){
            let imageData = UIImagePNGRepresentation(self.userImage.image!)
            let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            print(base64String.characters.count)
        } else{
            print("nil")
        }
    }
    
    func sendMessageToServer(){
        let jsonData = ["account" : self.account.text!, "name" : self.name.text!, "sex" : self.gender.text!, "age" : self.age.text!]
        
        var dataString : NSString = ""
        do{
            let data = try NSJSONSerialization.dataWithJSONObject(jsonData, options: [])
            dataString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        } catch{
            print("serialization json data error")
        }
        let url : String = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/userModify.action?userJson=" + (dataString as String)
        NetworkTool.networkTool.urlRequest(url, function: modifyUserInfo)
    }
    
    func getUserInfoFromServer(){
        
    }
    
    func modifyUserInfo(result : String){
        
        switch result {
        case "INVALID_JSON_STR":
            AlertMessage.alertFunction("Unknown error", uiViewController: self)
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
            self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("LoginViewController"))!, animated: true, completion: nil)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.getUserInfoFromServer()
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
