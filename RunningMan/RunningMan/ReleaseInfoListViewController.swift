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
        print("confirm")
    }
    
    @IBAction func cancel(){
        let toView : UIView = (storyboard?.instantiateViewControllerWithIdentifier("InfoListViewController").view)!
        let fromView:UIView! = self.view
        
        print("any thing")
        
        // Transition using a page curl.
        UIView.transitionFromView(fromView, toView:toView,duration:0.5,
                                  options: UIViewAnimationOptions.TransitionFlipFromBottom,
                                  completion:nil
        );
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
