//
//  LoginViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

let isLTRLanguage = UIApplication.sharedApplication().userInterfaceLayoutDirection == .LeftToRight

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var account : SkyFloatingLabelTextField!
    @IBOutlet weak var password : SkyFloatingLabelTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var regesterButton: UIButton!

    
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    
    @IBAction func login(){
        let url = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/userLogin.action?userAccount=\(account.text!)&pwd=\(password.text!)"
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
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "login")
        self.view.insertSubview(backgroundImage, atIndex: 0)
      

      //  self.applySkyscannerTheme(self.account)
        
        setupThemeColors()
//        self.account.text = "GuoQi"
//        self.password.text = "123456"
        
    }
    func setupThemeColors() {
        
        self.loginButton.layer.borderColor = darkGreyColor.CGColor
        self.loginButton.layer.borderWidth = 1
        self.loginButton.layer.cornerRadius = 5
        self.loginButton.setTitleColor(overcastBlueColor, forState: .Highlighted)
        self.regesterButton.layer.borderColor = darkGreyColor.CGColor
        self.regesterButton.layer.borderWidth = 1
        self.regesterButton.layer.cornerRadius = 5
        self.regesterButton.setTitleColor(overcastBlueColor, forState: .Highlighted)
        
        self.account.placeholder     = NSLocalizedString("Account", tableName: "SkyFloatingLabelTextField", comment: "")
        self.account.selectedTitle   = NSLocalizedString("Account", tableName: "SkyFloatingLabelTextField", comment: "")
        self.account.title           = NSLocalizedString("Account", tableName: "SkyFloatingLabelTextField", comment: "")
        
        self.password.placeholder     = NSLocalizedString("Password", tableName: "SkyFloatingLabelTextField", comment: "")
        self.password.selectedTitle   = NSLocalizedString("Password", tableName: "SkyFloatingLabelTextField", comment: "")
        self.password.title           = NSLocalizedString("Password", tableName: "SkyFloatingLabelTextField", comment: "")
        
        self.applySkyscannerTheme(self.account)
        self.applySkyscannerTheme(self.password)
        
        account.delegate = self
        password.delegate = self
        password.secureTextEntry = true
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
    
    
}

