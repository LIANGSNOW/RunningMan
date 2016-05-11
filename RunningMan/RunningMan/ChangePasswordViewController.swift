//
//  ChangePasswordViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var oldPassword : SkyFloatingLabelTextField!
    @IBOutlet weak var newPassword : SkyFloatingLabelTextField!
    @IBOutlet weak var reNewPassword : SkyFloatingLabelTextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)

    @IBAction func confirm(sender : AnyObject){
        
        if(newPassword.text != reNewPassword.text){
            AlertMessage.alertFunction("The re-new password should be the same as new password", uiViewController: self)
        }
        
        let url = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/modifyPwd.action?userAccount=\(ApplicationSession.loginedUserId)&originalPwd=\(oldPassword.text!)&newPwd=\(newPassword.text!)"
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
              
        self.oldPassword.placeholder     = NSLocalizedString("OldPassword", tableName: "SkyFloatingLabelTextField", comment: "")
        self.oldPassword.selectedTitle   = NSLocalizedString("OldPassword", tableName: "SkyFloatingLabelTextField", comment: "")
        self.oldPassword.title           = NSLocalizedString("OldPassword", tableName: "SkyFloatingLabelTextField", comment: "")
        
        self.newPassword.placeholder     = NSLocalizedString("NewPassword", tableName: "SkyFloatingLabelTextField", comment: "")
        self.newPassword.selectedTitle   = NSLocalizedString("NewPassword", tableName: "SkyFloatingLabelTextField", comment: "")
        self.newPassword.title           = NSLocalizedString("NewPassword", tableName: "SkyFloatingLabelTextField", comment: "")
        
        self.reNewPassword.placeholder     = NSLocalizedString("ReNewPassword", tableName: "SkyFloatingLabelTextField", comment: "")
        self.reNewPassword.selectedTitle   = NSLocalizedString("ReNewPassword", tableName: "SkyFloatingLabelTextField", comment: "")
        self.reNewPassword.title           = NSLocalizedString("ReNewPassword", tableName: "SkyFloatingLabelTextField", comment: "")

        
        self.applySkyscannerTheme(self.oldPassword)
        self.applySkyscannerTheme(self.newPassword)
        self.applySkyscannerTheme(self.reNewPassword)

        oldPassword.delegate = self
        oldPassword.secureTextEntry = true
        newPassword.delegate = self
        newPassword.secureTextEntry = true
        reNewPassword.delegate = self
        reNewPassword.secureTextEntry = true
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
