//
//  UserInfoViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var account : UITextField!
    @IBOutlet weak var name : UITextField!
    @IBOutlet weak var gender : UITextField!
    @IBOutlet weak var age : UITextField!
    @IBOutlet weak var weight : UITextField!
    @IBOutlet weak var height : UITextField!
    
    @IBOutlet weak var userImage : UIImageView!
    
    @IBAction func confirm(sender : AnyObject){
        
    }
    
    @IBAction func changePassword(sender : AnyObject){
        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("ChangePasswordViewController"))!, animated: true, completion: nil)
    }
    
    @IBAction func cancel(sender : AnyObject){
        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("TabBarController"))!, animated: true, completion: nil)
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
