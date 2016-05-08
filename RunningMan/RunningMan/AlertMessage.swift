//
//  AlertMessage.swift
//  RunningMan
//
//  Created by zz on 5/8/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import Foundation
import UIKit

class AlertMessage {
    class func alertFunction(message : String, uiViewController : UIViewController){
        let alertController = UIAlertController(title: "Alert Message", message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        uiViewController.presentViewController(alertController, animated: true, completion: nil)
    }
}