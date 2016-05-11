//
//  ModelTest.swift
//  RunningMan
//
//  Created by zz on 5/11/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import XCTest
@testable import RunningMan

class ModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUser() {
        let user = User(account : "account", password : "123456", name : "test", sex : "male", age : "20", desc : "hello", photo : UIImage())
        XCTAssertNotNil(user)
        XCTAssertEqual(user.age, "20")
    }
    
    func testInfoList(){
        let user = User(account : "account", password : "123456", name : "test", sex : "male", age : "20", desc : "hello", photo : UIImage())
        let infoList = InfoList(user : user, content : "Content", date : "2016-5-11", pic : UIImage())
        XCTAssertNotNil(infoList)
        XCTAssertEqual(infoList.content, "Content")
    }
    
    func testSteps(){
        let user = User(account : "account", password : "123456", name : "test", sex : "male", age : "20", desc : "hello", photo : UIImage())
        let stepRecords = StepsRecord(user : user, date : NSDate(), stepsCount : 1000)
        XCTAssertNotNil(stepRecords)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
