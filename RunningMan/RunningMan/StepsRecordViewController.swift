//
//  StepsRecordViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class StepsRecordViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!

    
    var arrayStep:[String] = ["11","346546","1"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self

 //       SqlConnection().displayAll(self.arrayStep)
        table.reloadData()
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

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return self.arrayStep.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath)
        let row = indexPath.row as Int
        cell.textLabel!.text = arrayStep[row]
        return cell
    }
    
}
