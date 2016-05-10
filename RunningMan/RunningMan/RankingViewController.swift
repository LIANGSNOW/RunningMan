//
//  RankingViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var rankDayArray : NSMutableArray = NSMutableArray()
    var rankWeekArray : NSMutableArray = NSMutableArray()
    var displayArray : NSMutableArray = NSMutableArray()
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let url = "http://192.168.0.16:8080/IOSApp/mobile/getStepsSortedListByDay.action"
        NetworkTool.networkTool.urlRequest(url, function: getRankInfoFromServer)
        let url1 = "http://192.168.0.16:8080/IOSApp/mobile/getStepsSortedListByThisWeek.action"
        NetworkTool.networkTool.urlRequest(url1, function: getRankByWeek)
        self.table.delegate = self
        self.table.dataSource = self
        
    }
    
     func getRankByWeek(result:String){
        let data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        rankWeekArray.removeAllObjects();
        do{
            
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
            
            for item in (jsonData as! NSMutableArray){
                let name : String = (item as! NSDictionary).valueForKey("userAccount") as! String
                let steps : String = (item as! NSDictionary).valueForKey("steps") as! String
                let content = "name:" + name + "    steps:" + steps
                self.rankWeekArray.addObject(content)
            }
            
        } catch {
            print("convert json string to array error")
        }

    }
    
    
    @IBAction func showRankByWeek(){
        displayArray.removeAllObjects();
        var i:Int = 0;
        for item in rankWeekArray {
            displayArray[i] = item
            i += 1;
        }
        self.table.reloadData()
    }
    
    @IBAction func showRankByDay(){
        displayArray.removeAllObjects();
        var i : Int = 0;
        for item in rankDayArray {
            displayArray[i] = item
            i += 1;
        }
        self.table.reloadData()
        //refresh the table view in the controller
    }
    
    
    func getRankInfoFromServer(result : String){
        let data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        rankDayArray.removeAllObjects();
        do{
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
            
            for item in (jsonData as! NSMutableArray){
                let name : String = (item as! NSDictionary).valueForKey("userAccount") as! String
                let steps : String = (item as! NSDictionary).valueForKey("steps") as! String
                let content = "name:" + name + "    steps:" + steps
                self.rankDayArray.addObject(content)
                }
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
        return self.displayArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.displayArray.objectAtIndex(indexPath.row) as! String
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
