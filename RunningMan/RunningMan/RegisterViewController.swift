//
//  RegisterViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var account : UITextField!
    @IBOutlet weak var password : UITextField!
    @IBOutlet weak var rePassword : UITextField!
    
    @IBAction func register(sender : AnyObject){
        
        let jsonData = ["account" : self.account.text!, "password" : self.password.text!]
        
        if(password.text != rePassword.text){
            AlertMessage.alertFunction("The password and re-password should be same", uiViewController: self)
        }
        
        var dataString : NSString = ""
        do{
            let data = try NSJSONSerialization.dataWithJSONObject(jsonData, options: [])
            dataString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        } catch{
            print("serialization json data error")
        }
        let url : String = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/userRegister.action?userJson=" + (dataString as String)
        NetworkTool.networkTool.urlRequest(url, function: registerNewUser)
    }
    
    @IBAction func cancel(sender : AnyObject){
        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("LoginViewController"))!, animated: true, completion: nil)
    }
    
    func registerNewUser(result : String){

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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
