//
//  RegisterViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var account : SkyFloatingLabelTextField!
    @IBOutlet weak var password : SkyFloatingLabelTextField!
    @IBOutlet weak var rePassword : SkyFloatingLabelTextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    
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
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "backgroud")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        setupThemeColors() 
          }
    
    func setupThemeColors() {
        
        self.confirmButton.layer.borderColor = darkGreyColor.CGColor
        self.confirmButton.layer.borderWidth = 1
        self.confirmButton.layer.cornerRadius = 5
        self.confirmButton.setTitleColor(overcastBlueColor, forState: .Highlighted)
        self.cancelButton.layer.borderColor = darkGreyColor.CGColor
        self.cancelButton.layer.borderWidth = 1
        self.cancelButton.layer.cornerRadius = 5
        self.cancelButton.setTitleColor(overcastBlueColor, forState: .Highlighted)
        
        self.account.placeholder     = NSLocalizedString("Account", tableName: "SkyFloatingLabelTextField", comment: "")
        self.account.selectedTitle   = NSLocalizedString("Account", tableName: "SkyFloatingLabelTextField", comment: "")
        self.account.title           = NSLocalizedString("Account", tableName: "SkyFloatingLabelTextField", comment: "")
        
        self.password.placeholder     = NSLocalizedString("Password", tableName: "SkyFloatingLabelTextField", comment: "")
        self.password.selectedTitle   = NSLocalizedString("Password", tableName: "SkyFloatingLabelTextField", comment: "")
        self.password.title           = NSLocalizedString("Password", tableName: "SkyFloatingLabelTextField", comment: "")
        
        self.rePassword.placeholder     = NSLocalizedString("RePassword", tableName: "SkyFloatingLabelTextField", comment: "")
        self.rePassword.selectedTitle   = NSLocalizedString("RePassword", tableName: "SkyFloatingLabelTextField", comment: "")
        self.rePassword.title           = NSLocalizedString("RePassword", tableName: "SkyFloatingLabelTextField", comment: "")

        
        self.applySkyscannerTheme(self.account)
        self.applySkyscannerTheme(self.password)
        self.applySkyscannerTheme(self.rePassword)

        
        account.delegate = self
        password.delegate = self
        rePassword.delegate = self
        password.secureTextEntry = true
        rePassword.secureTextEntry = true
    }
    
    func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {
        
        textField.tintColor = overcastBlueColor
        
        textField.textColor = darkGreyColor
        textField.lineColor = lightGreyColor
        
        textField.selectedTitleColor = overcastBlueColor
        textField.selectedLineColor = overcastBlueColor
        
        // Set custom fonts for the title, placeholder and textfield labels
        textField.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        textField.placeholderFont = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
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
