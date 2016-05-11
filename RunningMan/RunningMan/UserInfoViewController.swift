//
//  UserInfoViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate , UITextFieldDelegate{
    
    @IBOutlet weak var account : SkyFloatingLabelTextField!
    @IBOutlet weak var name : SkyFloatingLabelTextField!
    @IBOutlet weak var gender : SkyFloatingLabelTextField!
    @IBOutlet weak var age : SkyFloatingLabelTextField!
    @IBOutlet weak var weight : UITextField!
    @IBOutlet weak var height : UITextField!
    @IBOutlet weak var confirmButton :UIButton!
    @IBOutlet weak var changeButton :UIButton!
    @IBOutlet weak var logOutButton :UIButton!
    
    var genderArray:Array<String>?
    
    @IBOutlet weak var userImage : UIImageView!
    var imagePicker = UIImagePickerController()
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genderArray = ["Male","Female"]
        
        let pickerView:UIPickerView=UIPickerView()
        pickerView.delegate=self
        pickerView.dataSource=self
        gender.inputView=pickerView
        // Do any additional setup after loading the view.
        self.getUserInfoFromServer()
        self.account.text! = ApplicationSession.loginedUserId
        self.account.delegate = self
        self.name.delegate = self
        self.age.delegate = self
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
        self.changeButton.layer.borderColor = darkGreyColor.CGColor
        self.changeButton.layer.borderWidth = 1
        self.changeButton.layer.cornerRadius = 5
        self.changeButton.setTitleColor(overcastBlueColor, forState: .Highlighted)
        self.logOutButton.layer.borderColor = darkGreyColor.CGColor
        self.logOutButton.layer.borderWidth = 1
        self.logOutButton.layer.cornerRadius = 5
        self.logOutButton.setTitleColor(overcastBlueColor, forState: .Highlighted)
        
        self.account.placeholder     = NSLocalizedString("Account", tableName: "SkyFloatingLabelTextField", comment: "")
        self.account.selectedTitle   = NSLocalizedString("Account", tableName: "SkyFloatingLabelTextField", comment: "")
        self.account.title           = NSLocalizedString("Account", tableName: "SkyFloatingLabelTextField", comment: "")
        
        self.name.placeholder     = NSLocalizedString("Name", tableName: "SkyFloatingLabelTextField", comment: "")
        self.name.selectedTitle   = NSLocalizedString("Name", tableName: "SkyFloatingLabelTextField", comment: "")
        self.name.title           = NSLocalizedString("Name", tableName: "SkyFloatingLabelTextField", comment: "")
        
        self.age.placeholder     = NSLocalizedString("Age", tableName: "SkyFloatingLabelTextField", comment: "")
        self.age.selectedTitle   = NSLocalizedString("Age", tableName: "SkyFloatingLabelTextField", comment: "")
        self.age.title           = NSLocalizedString("Age", tableName: "SkyFloatingLabelTextField", comment: "")

        
        self.gender.placeholder     = NSLocalizedString("Gender", tableName: "SkyFloatingLabelTextField", comment: "")
        self.gender.selectedTitle   = NSLocalizedString("Gender", tableName: "SkyFloatingLabelTextField", comment: "")
        self.gender.title           = NSLocalizedString("Gender", tableName: "SkyFloatingLabelTextField", comment: "")
        
        
        self.applySkyscannerTheme(self.account)
        self.applySkyscannerTheme(self.name)
        self.applySkyscannerTheme(self.gender)
        self.applySkyscannerTheme(self.age)

       
       
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

    @IBAction func confirm(sender : AnyObject){
        
        var jsonData = ["account" : self.account.text!, "name" : self.name.text!, "sex" : self.gender.text!, "age" : self.age.text!]
        
        var dataString : NSString = ""
        
        if(self.userImage.image != nil){
            jsonData["img"] = ImageBase64Tool.convertImageToBase64(self.userImage.image!)
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
        if(dictionary!["name"] != nil){
            self.name.text = (dictionary!["name"] as! String)
        }
        if(dictionary!["name"] != nil){
            self.gender.text = (dictionary!["sex"] as! String)
        }
        if(dictionary!["name"] != nil){
            self.age.text = (dictionary!["age"] as! String)
        }
        
        if(dictionary!["img"] != nil){
            let base64String = dictionary!["img"] as! String
            
            self.userImage.image = ImageBase64Tool.convertBase64ToImage(base64String)
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component:Int) -> Int {
        return genderArray!.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArray![row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text=genderArray![row]
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(account: UITextField!) -> Bool {
        account.resignFirstResponder()
        return true;
    }
    
    @IBAction func logout(sender : AnyObject){
        ApplicationSession.loginedUserId = ""
        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("LoginViewController"))!, animated: true, completion: nil)
    }
    
//    func nameShouldReturn(name:UITextField!) -> Bool{
//        name.resignFirstResponder()
//        return true;
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
