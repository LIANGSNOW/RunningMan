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
    var refreshControl: UIRefreshControl!
    var displayArray:[String] = []
    var timeArray:[String] = []
    
   // var tableViewController = UITableViewController()
    

    var customView: UIView!
    
    var labelsArray: Array<UILabel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        SqlConnection().displayAll(updateArray)
        table.reloadData()
        //table = tableViewController.tableView
        //tableViewController.refreshControl = self.refreshControl
        //self.refreshControl.addTarget(self, action: "didRefreshList", forControlEvents: .ValueChanged)
        
        //self.view.addSubview(refreshControl)
        refreshControl = UIRefreshControl()
       
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action:"refresh:", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.backgroundColor = UIColor.grayColor()
        refreshControl.tintColor = UIColor.blackColor()
        table.addSubview(refreshControl)
       // loadCustomRefreshContents()
    }
    
   
    func refresh(sender:AnyObject) {
       self.table.delegate = self
        self.table.dataSource = self
        SqlConnection().displayAll(updateArray)
        table.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func loadCustomRefreshContents() {
//        let refreshContents = NSBundle.mainBundle().loadNibNamed("RefreshContents", owner: self, options: nil)
//        customView = refreshContents[0] as! UIView
//        customView.frame = refreshControl.bounds
//        for var i=0; i<customView.subviews.count; i += 1 {
//            labelsArray.append(customView.viewWithTag(i + 1) as! UILabel)
//        }
//        refreshControl.addSubview(customView)
    }
    
    func updateArray(array : [String]){
        self.displayArray.removeAll()
        for item in array{
            self.displayArray.append(item)
        }
        //table.reloadData()
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
        return self.displayArray.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath)
        let row = indexPath.row as Int
        cell.textLabel!.text = displayArray[row]
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }}
