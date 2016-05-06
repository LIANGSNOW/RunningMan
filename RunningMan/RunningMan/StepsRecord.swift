//
//  StepsRecord.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import Foundation

class StepsRecord{
    var user : User?
    var date : NSDate?
    var stepsCount : Int = 0
    
    init(user : User, date : NSDate, stepsCount : Int){
        self.user = user
        self.date = date
        self.stepsCount = stepsCount
    }
    
}