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
        
    }
    
    @IBAction func cancel(sender : AnyObject){
        
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
