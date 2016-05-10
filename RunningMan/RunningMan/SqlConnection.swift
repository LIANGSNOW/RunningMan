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
    //let docsDir = "/Users/mac/RunningTest.sqlite"
    var database : COpaquePointer = nil
    var insertSteps: COpaquePointer = nil
    var displaySteps: COpaquePointer = nil
    
    let SQLITE_TRANSIENT = unsafeBitCast(-1, sqlite3_destructor_type.self)
    
    static let sqlConnection = SqlConnection()

    init(){
        if(sqlite3_open(docsDir, &database) == SQLITE_OK){
            let sqldelete = "DROP TABLE RUNNING_MAN"
            let sql = "CREATE TABLE IF NOT EXISTS RUNNING_MAN(ID INTEGER PRIMARY KEY AUTOINCREMENT, ACCOUNT TEXT, DATE TEXT, STEPS_COUNT TEXT,TIMEPERIOD TEXT)"
            
            if(sqlite3_exec(database, sql, nil, nil, nil) != SQLITE_OK){
                print("Failed to create table")
                print(sqlite3_errmsg(database))
            }
        } else {
            print("Failed to open database")
            print(sqlite3_errmsg(database))
        }
        print(docsDir)
        prepareStartment()
    }
    
    func prepareStartment(){
        var sqlString : String
      
        sqlString = "INSERT INTO RUNNING_MAN(account,date,steps_count,timeperiod) VALUES (?,?,?,?)"
        var cSql = sqlString.cStringUsingEncoding(NSUTF8StringEncoding)
        sqlite3_prepare_v2(database, cSql!, -1, &insertSteps, nil)

        sqlString = "SELECT steps_count,timeperiod FROM RUNNING_MAN"
        cSql = sqlString.cStringUsingEncoding(NSUTF8StringEncoding)
        sqlite3_prepare_v2(database, cSql!, -1, &displaySteps, nil)

    }
    
    func createSteps(account:String,date:String,step:String,timeperiod:String ){
        
        let accountStr = account as NSString?
        let dateStr = date as NSString?
        let stepStr = step as NSString?
        let periodStr = timeperiod as NSString?
        
        sqlite3_bind_text(insertSteps, 1, accountStr!.UTF8String, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(insertSteps, 2, dateStr!.UTF8String, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(insertSteps, 3, stepStr!.UTF8String, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(insertSteps, 4, periodStr!.UTF8String, -1, SQLITE_TRANSIENT)
        if(sqlite3_step(insertSteps) == SQLITE_DONE){
           print("Contact added")
        }
        else{
            print("Failed to add contact")
            print("Error code: ", sqlite3_errcode(database))
            let error = String.fromCString(sqlite3_errmsg(database))
            print("Error msg: ", error)
        }
        sqlite3_reset(insertSteps)
        sqlite3_clear_bindings(insertSteps)

    }
    
    func displayAll(function : ([String],[String]) -> ()) {
        var arrayTime : [String] = []
        var arrayStep : [String] = []
        while(sqlite3_step(displaySteps)  == SQLITE_ROW){
           
            let step_buf = sqlite3_column_text(displaySteps, 0)
            let period_buf = sqlite3_column_text(displaySteps, 1)
            arrayTime.append(String.fromCString(UnsafePointer<CChar>(step_buf))!)
            arrayStep.append(String.fromCString(UnsafePointer<CChar>(period_buf))!)
            function(arrayStep,arrayTime)
        }
    
        sqlite3_reset(displaySteps)
        sqlite3_clear_bindings(displaySteps)
   
    }
}