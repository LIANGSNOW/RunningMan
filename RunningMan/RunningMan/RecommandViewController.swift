//
//  RecommandViewController.swift
//  RunningMan
//
//  Created by mac on 11/6/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import Foundation
import UIKit

class RecommandViewController: UIViewController{
    @IBOutlet weak var getStepsByHeuBtn: UIButton!
    @IBOutlet weak var getStepsBysleBtn: UIButton!
    @IBOutlet weak var recomStep: UITextView!
    @IBOutlet weak var recomSlep: UITextView!
    
    var sleepTimeArray : NSMutableArray = NSMutableArray()
    var sleepQualityArray : NSMutableArray = NSMutableArray()

    
    override func viewDidLoad() {
            super.viewDidLoad()
        sleepTimeArray.addObject("8")
        sleepTimeArray.addObject("8")
        sleepTimeArray.addObject("8")
        sleepQualityArray.addObject("H")
        sleepQualityArray.addObject("H")
        sleepQualityArray.addObject("H")
        
        let randomTime:UInt32 = arc4random_uniform(3)
        let randomQuality:UInt32 = arc4random_uniform(3)
        print(sleepTimeArray.objectAtIndex(Int(randomTime)))
        print(sleepQualityArray.objectAtIndex(Int(randomQuality)))
        let url = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/updateTrainingData.action?userAccount=\(ApplicationSession.loginedUserId)&sleepingTime=\(sleepTimeArray.objectAtIndex(Int(randomTime)))&sleepingQuality=\(sleepQualityArray.objectAtIndex(Int(randomQuality)))"
        NetworkTool.networkTool.urlRequest(url, function: uploadSleepStatus, method: "POST")
        getSleepFormStep()
        getSleepFormTime()
    }
    
    func uploadSleepStatus(result : String){
        
        switch result {
        case "SUCCESS":
            print("success")
            break
        case "FAILURE":
            print("failed")
            break
        case "NO_YESTERDAY_DATA":
            print("Not Yesterday Data")
            break

        default:
            break
        }
        
    }
    
    func getSleepFormStep(){
        let url = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/predictStepsByPersonalInfo.action?userAccount=\(ApplicationSession.loginedUserId)"
        NetworkTool.networkTool.urlRequest(url, function: getSleepStep, method: "POST")
    }
    
    func getSleepStep(result : String){
        
        switch result {
        case "ERROR":
            print("ERROR")
            break

        default:
            recomStep.text = "We recommand you do a \(result) steps running today "
            recomStep.editable = false
           // AlertMessage.alertFunction(result, uiViewController: self)
            break
        }
        
    }
    
   func getSleepFormTime(){
        let randomTime:UInt32 = arc4random_uniform(3)
        let randomQuality:UInt32 = arc4random_uniform(3)
        let url = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/predictStepsBySleepingQuality.action?userAccount=\(ApplicationSession.loginedUserId)&sleepingTime=\(sleepTimeArray.objectAtIndex(Int(randomTime)))&sleepingQuality=\(sleepQualityArray.objectAtIndex(Int(randomQuality)))"
        NetworkTool.networkTool.urlRequest(url, function: getSleepTime, method: "POST")
    }
    
    func getSleepTime(result : String){
        
        switch result {
        case "ERROR":
            print("ERROR")
            break
            
        default:
            recomSlep.text = "We recommand you do a \(result)0 steps running today by your sleeping quality of yesterday"
            recomSlep.editable = false
          //  AlertMessage.alertFunction(result, uiViewController: self)
            break
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}