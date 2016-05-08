//
//  ReleaseInfoListViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class ReleaseInfoListViewController: UIViewController {
    
    @IBOutlet weak var content : UITextView!
    
    @IBAction func confirm(){
        if(content.text == ""){
            AlertMessage.alertFunction("The content couldn't be null", uiViewController: self)
        }
        
        let url = "http://192.168.0.16:8080/IOSApp/mobile/postMessage.action?userAccount=\(ApplicationSession.loginedUserId)&content=\(content.text!)"
        NetworkTool.networkTool.urlRequest(url, function: releaseInfoList)
    }
    
    func releaseInfoList(result : String){
        
        switch result {
        case "EMPTY_USER_ACCOUNT":
            AlertMessage.alertFunction("please input the user account", uiViewController: self)
            break
        case "ACCOUNT_NOT_EXISTED":
            AlertMessage.alertFunction("The user account doesn't exist", uiViewController: self)
            break
        case "EMPTY_CONTENT":
            AlertMessage.alertFunction("The password is incorrect", uiViewController: self)
            break
        case "ERROR":
            AlertMessage.alertFunction("Unknown error", uiViewController: self)
            break
        case "SUCCESS":
            //please add an page jump function here
            
            AlertMessage.alertFunction("Release Info List success", uiViewController: self)
            break
        default:
            break
        }
    }
    
    @IBAction func cancel(){
        let tabBarController : UITabBarController = storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
        
        self.presentViewController(tabBarController, animated: true, completion: nil)
        
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
