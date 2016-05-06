//
//  User.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import Foundation
import UIKit

class User{

    var account : String = ""
    var password : String = ""
    var name : String = ""
    var sex : String = ""
    var age : String = ""
    var desc : String = ""
    var photo : UIImage?
    
    init(account : String, password : String, name : String, sex : String, age : String, desc : String, photo : UIImage){
        self.account = account
        self.password = password
        self.name = name
        self.sex = sex
        self.age = age
        self.desc = desc
        self.photo = photo
    }
    
}