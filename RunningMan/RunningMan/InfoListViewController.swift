//
//  InfoListViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class InfoListViewController: UITableViewController {
    
    @IBOutlet weak var newButton:UIBarButtonItem!
    
    var infoListArray : NSMutableArray = NSMutableArray()
    var detailViewController: InfoListDetailController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? InfoListDetailController
        }
        
        if detailViewController == nil{
            detailViewController = storyboard?.instantiateViewControllerWithIdentifier("InfoListDetail") as? InfoListDetailController
        }
        let url = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/viewAllPosts.action"
        NetworkTool.networkTool.urlRequest(url, function: getInfoListsFromServer)
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func refresh(sender:AnyObject)
    {
        infoListArray.removeAllObjects()
        let url = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/viewAllPosts.action"
        NetworkTool.networkTool.urlRequest(url, function: getInfoListsFromServer)
        
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    func getInfoListsFromServer(result : String){
        let data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        do{
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
            
            for item in (jsonData as! NSMutableArray){
                let temp = item as! NSDictionary
                let user : User = User()
                let infoList : InfoList = InfoList()
                infoList.content = temp["content"] as! String
                infoList.date = temp["date"] as! String
                infoList.id = temp["id"] as! String
                user.account = temp["userAccount"] as! String
                let img : String = temp["img"] as! String
                if(img != ""){
                    user.photo = ImageBase64Tool.convertBase64ToImage(img)
                }
                infoList.user = user
                self.infoListArray.addObject(infoList)
            }
            
            //refresh the table view in the controller
            self.tableView.reloadData()
        } catch {
            print("convert json string to array error")
        }
    }
   
    override func viewWillAppear(animated: Bool) {
        
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
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let detail = infoListArray.objectAtIndex(indexPath.row) as! InfoList
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! InfoListDetailController
                controller.detail = detail
                
            }
        }
    }
    
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.infoListArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = (self.infoListArray.objectAtIndex(indexPath.row) as! InfoList).content
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
}
