//
//  InfoListDetailController.swift
//  RunningMan
//
//  Created by zz on 5/8/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class InfoListDetailController: UIViewController{
    
    @IBOutlet weak var userImage : UIImageView!
    @IBOutlet weak var userName : UILabel!
    @IBOutlet weak var infoListContent : UILabel!
    
    var detail : InfoList!
    

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
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        userName.text = self.detail.user?.account
        infoListContent.text = self.detail.content
        if(self.detail.user?.photo != nil){
            userImage.image = self.detail.user?.photo
        }
    }
    
}
