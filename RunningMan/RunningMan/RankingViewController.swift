//
//  RankingViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var rankArray : NSMutableArray = NSMutableArray()
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let url = "http://192.168.0.16:8080/IOSApp/mobile/getStepsSortedListByDay.action"
        NetworkTool.networkTool.urlRequest(url, function: getRankInfoFromServer)
        self.table.delegate = self
        self.table.dataSource = self
        
    }
    
    func getRankInfoFromServer(result : String){
        let data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        do{
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
            
            for item in (jsonData as! NSMutableArray){
                let name : String = (item as! NSDictionary).valueForKey("userAccount") as! String
                let steps : String = (item as! NSDictionary).valueForKey("steps") as! String
                let content = "name:" + name + "    steps:" + steps
                self.rankArray.addObject(content)
            }
            self.table.reloadData()
            //refresh the table view in the controller
            
        } catch {
            print("convert json string to array error")
        }
        
        
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
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rankArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.rankArray.objectAtIndex(indexPath.row) as! String
        //  print(self.infoListArray.objectAtIndex(indexPath.row) as! String)
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
}
