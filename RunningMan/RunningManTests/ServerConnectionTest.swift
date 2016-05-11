//
//  ServerConnectionTest.swift
//  RunningMan
//
//  Created by zz on 5/11/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import XCTest
@testable import RunningMan

class ServerConnectionTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoginFunc(){
        let url = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/userLogin.action?userAccount=test&pwd=123456"
        NetworkTool.networkTool.urlRequest(url, function: loginInformation)
        
    }
    
    func loginInformation(result : String){
        XCTAssertEqual(result, "SUCCESS")
    }


    func testErrorMessage(){
        let url = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/userLogin.action?userAccount=test&pwd=123456"
        NetworkTool.networkTool.urlRequest(url, function: errorMessageHandle)
    }
    
    func errorMessageHandle(result : String){
        XCTAssertEqual("ACCOUNT_NOT_EXISTED", result)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
