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
    @IBOutlet weak var infoListContent : UITextView!
    
    var isTheGoodButtonChecked : Bool = true
    
    var likeList : NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var goodLabel : UILabel!
    
    
   
    
    @IBAction func good(send : AnyObject){
        self.getLikeList()
        if let stringArray = self.likeList as NSArray as? [String] {
            // Use swiftArray here
            if(!stringArray.contains(ApplicationSession.loginedUserId) && self.isTheGoodButtonChecked){
                self.isTheGoodButtonChecked = false
                let url = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/likePost.action?postId=\(self.detail.id)&userAccount=\(ApplicationSession.loginedUserId)"
                NetworkTool.networkTool.urlRequest(url, function: handlerForGood)
            } else{
                AlertMessage.alertFunction("You have already support for this post", uiViewController: self)
            }
        }
    }
    
    func handlerForGood(result : String){
        if("POST_NOT_EXISTED" == result){
            AlertMessage.alertFunction("POST NOT EXISTED", uiViewController: self)
        } else if("ERROR" == result){
            AlertMessage.alertFunction("Unknown Error", uiViewController: self)
        } else if("SUCCESS" == result){
            goodLabel.text = String(Int(goodLabel.text!)! + 1)
        }
    }
    
    var detail : InfoList!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.getLikeList()
    }
    
    func getLikeList(){
        let url = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/getLikedListByPostId.action?postId=\(self.detail.id)"
        NetworkTool.networkTool.urlRequest(url, function: handlerForGetListList)
    }
    
    func handlerForGetListList(result : String){
        if("POST_NOT_EXISTED" == result){
            AlertMessage.alertFunction("POST NOT EXISTED", uiViewController: self)
        } else if("ERROR" == result){
            AlertMessage.alertFunction("Unknown Error", uiViewController: self)
        } else {
            let data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            do{
                self.likeList = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
            } catch {
                print("convert json string to array error")
            }
            self.goodLabel.text = String(self.likeList.count)
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
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        userName.text = self.detail.user?.account
        infoListContent.text = self.detail.content
        if(self.detail.user?.photo != nil){
            userImage.image = self.detail.user?.photo
        }
    }
    
}
