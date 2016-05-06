//
//  SqlConnection.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import Foundation


class SqlConnection{
    
    //define variables
    
    let docsDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String + "/RunningMan.sqlite"
    
    var database : COpaquePointer = nil
    
    let SQLITE_TRANSIENT = unsafeBitCast(-1, sqlite3_destructor_type.self)
    
    static let sqlConnection = SqlConnection()

    private init(){
        if(sqlite3_open(docsDir, &database) == SQLITE_OK){
            let sql = "CREATE TABLE IF NOT EXISTS RUNNING_MAN(ID INTEGER PRIMARY KEY AUTOINCREMENT, USER_ID INTEGER, DATE TEXT, STEPS_COUNT INTEGER)"
            
            if(sqlite3_exec(database, sql, nil, nil, nil) != SQLITE_OK){
                print("Failed to create table")
                print(sqlite3_errmsg(database))
            }
        } else {
            print("Failed to open database")
            print(sqlite3_errmsg(database))
        }
    }
}