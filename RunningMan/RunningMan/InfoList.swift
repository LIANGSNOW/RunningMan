//
//  InfoList.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import Foundation
import UIKit

class InfoList {

    var user : User?
    var content : String = ""
    var date : NSDate?
    var pic : UIImage?
    
    init(user : User, content : String, date : NSDate, pic : UIImage){
        self.user = user
        self.date = date
        self.content = content
        self.pic = pic
    }
    
}