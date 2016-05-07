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
        
        
        print(NetworkTool.networkTool.urlRequest(url))
        
//        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("TabBarController"))!, animated: true, completion: nil)
        
    }
    
    @IBAction func register(){
        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("RegisterViewController"))!, animated: true, completion: nil)
        
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

