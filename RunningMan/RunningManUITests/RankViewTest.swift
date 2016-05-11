//
//  RankViewTest.swift
//  RunningMan
//
//  Created by zz on 5/11/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import XCTest

class RankViewTest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRankFunction(){
        
        let app = XCUIApplication()
        app.buttons["Login"].tap()
        app.tabBars.buttons["Rank"].tap()
        app.buttons["Week"].tap()
        app.buttons["Day"].tap()
        
    }
    
}
