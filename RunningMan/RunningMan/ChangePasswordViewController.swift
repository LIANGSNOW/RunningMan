//
//  ChangePasswordViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var oldPassword : UITextField!
    @IBOutlet weak var newPassword : UITextField!
    @IBOutlet weak var reNewPassword : UITextField!
    
    @IBAction func confirm(sender : AnyObject){
        
        if(newPassword.text != reNewPassword.text){
            AlertMessage.alertFunction("The re-new password should be the same as new password", uiViewController: self)
        }
        
        let url = "http://192.168.0.16:8080/IOSApp/mobile/modifyPwd.action?userAccount=\(ApplicationSession.loginedUserId)&originalPwd=\(oldPassword.text!)&newPwd=\(newPassword.text!)"
        NetworkTool.networkTool.urlRequest(url, function: changePassword)
        
    }
    
    func changePassword(result : String){
        
        switch result {
        case "EMPTY_USER_ACCOUNT":
            AlertMessage.alertFunction("please input the user account", uiViewController: self)
            break
        case "ACCOUNT_NOT_EXISTED":
            AlertMessage.alertFunction("The user account doesn't exist", uiViewController: self)
            break
        case "ORIGINAL_PWD_ERROR":
            AlertMessage.alertFunction("The password is incorrect", uiViewController: self)
            break
        case "EMPTY_NEW_PWD":
            AlertMessage.alertFunction("Please in put the new password", uiViewController: self)
            break
        case "ERROR":
            AlertMessage.alertFunction("Unknown error", uiViewController: self)
            break
        case "SUCCESS":
            //please add an page jump function here
            
            AlertMessage.alertFunction("Change success", uiViewController: self)
            break
        default:
            break
        }
    }
    
    @IBAction func cancel(sender : AnyObject){
        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("TabBarController"))!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
