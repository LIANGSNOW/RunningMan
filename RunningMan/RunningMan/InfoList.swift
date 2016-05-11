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
    var date : String = ""
    var pic : UIImage?
    var id : String = ""
    
    init(){
        
    }
    
    init(user : User, content : String, date : String, pic : UIImage){
        self.user = user
        self.date = date
        self.content = content
        self.pic = pic
    }
    
    deinit{
        
    }
    
}