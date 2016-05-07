//
//  InfoListViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class InfoListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(InfoListViewController.insertNewObject))
        self.navigationItem.rightBarButtonItem = addButton
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(){
        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("ReleaseInfoListViewController"))!, animated: true, completion: nil)
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
