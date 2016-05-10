//
//  LoginViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var account : UITextField!
    @IBOutlet weak var password : UITextField!
    
    @IBAction func login(){
        let url = "http://192.168.0.16:8080/IOSApp/mobile/userLogin.action?userAccount=\(account.text!)&pwd=\(password.text!)"
        NetworkTool.networkTool.urlRequest(url, function: loginInformation)
        
    }
    
    func loginInformation(result : String){
        switch result {
        case "EMPTY_USER_ACCOUNT":
            AlertMessage.alertFunction("please input the user account", uiViewController: self)
            break
        case "ACCOUNT_NOT_EXISTED":
            AlertMessage.alertFunction("The user account doesn't exist", uiViewController: self)
            break
        case "PWD_ERROR":
            AlertMessage.alertFunction("The password is incorrect", uiViewController: self)
            break
        case "ERROR":
            AlertMessage.alertFunction("Unknown error", uiViewController: self)
            break
        case "SUCCESS":
            ApplicationSession.loginedUserId = account.text!
            self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("TabBarController"))!, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    
    
    
    @IBAction func register(){
        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("RegisterViewController"))!, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.account.text = "GuoQi"
        self.password.text = "123456"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

