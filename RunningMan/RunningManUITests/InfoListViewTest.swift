//
//  InfoListViewTest.swift
//  RunningMan
//
//  Created by zz on 5/11/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import XCTest

class InfoListViewTest: XCTestCase {
        
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
    
    func testIfCanGetThePosts(){
        
        let app = XCUIApplication()
        let accountElementsQuery = app.otherElements.containingType(.StaticText, identifier:"Account")
        accountElementsQuery.childrenMatchingType(.TextField).element.tap()
        accountElementsQuery.childrenMatchingType(.TextField).element
        
        let secureTextField = accountElementsQuery.childrenMatchingType(.SecureTextField).element
        secureTextField.tap()
        secureTextField.tap()
        accountElementsQuery.childrenMatchingType(.SecureTextField).element
        app.buttons["Login"].tap()
        app.tabBars.buttons["Post"].tap()
        
    }
    
    func testIfCanCheckTheDetail(){
        
        let app = XCUIApplication()
        let accountElementsQuery = app.otherElements.containingType(.StaticText, identifier:"Account")
        accountElementsQuery.childrenMatchingType(.TextField).element.tap()
        accountElementsQuery.childrenMatchingType(.TextField).element
        
        let secureTextField = accountElementsQuery.childrenMatchingType(.SecureTextField).element
        secureTextField.tap()
        secureTextField.tap()
        accountElementsQuery.childrenMatchingType(.SecureTextField).element
        app.buttons["Login"].tap()
        app.tabBars.buttons["Post"].tap()
        app.tables.staticTexts["text viewfasdf"].tap()
        
    }
    
    func testIfCanReleaseThePost(){
        
        let app = XCUIApplication()
        let accountElementsQuery = app.otherElements.containingType(.StaticText, identifier:"Account")
        accountElementsQuery.childrenMatchingType(.TextField).element.tap()
        accountElementsQuery.childrenMatchingType(.TextField).element
        
        let secureTextField = accountElementsQuery.childrenMatchingType(.SecureTextField).element
        secureTextField.tap()
        secureTextField.tap()
        accountElementsQuery.childrenMatchingType(.SecureTextField).element
        app.buttons["Login"].tap()
        app.tabBars.buttons["Post"].tap()
        app.navigationBars["Post"].buttons["Add"].tap()
        
        let element = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        element.childrenMatchingType(.TextView).element.tap()
        element.childrenMatchingType(.TextView).element
        app.buttons["Confirm"].tap()
        app.alerts["Alert Message"].collectionViews.buttons["OK"].tap()
        app.navigationBars["New Post"].buttons["Post"].tap()
        app.tables.childrenMatchingType(.Cell).elementBoundByIndex(0).staticTexts["big dick man"].tap()
        
    }
    
    func testIfCanSupportAPost(){
        
        let app = XCUIApplication()
        let accountElementsQuery = app.otherElements.containingType(.StaticText, identifier:"Account")
        accountElementsQuery.childrenMatchingType(.TextField).element.tap()
        accountElementsQuery.childrenMatchingType(.TextField).element
        
        let secureTextField = accountElementsQuery.childrenMatchingType(.SecureTextField).element
        secureTextField.tap()
        secureTextField.tap()
        accountElementsQuery.childrenMatchingType(.SecureTextField).element
        app.buttons["Login"].tap()
        app.tabBars.buttons["Post"].tap()
        app.tables.staticTexts["text view this is a test message"].tap()
        app.buttons["good"].tap()
        app.navigationBars["Master"].buttons["Post"].tap()
        
    }
    
    func testIfCanGetTheErrorMessageWithDumpSupport(){
        
        let app = XCUIApplication()
        let accountElementsQuery = app.otherElements.containingType(.StaticText, identifier:"Account")
        accountElementsQuery.childrenMatchingType(.TextField).element.tap()
        accountElementsQuery.childrenMatchingType(.TextField).element
        
        let secureTextField = accountElementsQuery.childrenMatchingType(.SecureTextField).element
        secureTextField.tap()
        secureTextField.tap()
        accountElementsQuery.childrenMatchingType(.SecureTextField).element
        app.buttons["Login"].tap()
        app.tabBars.buttons["Post"].tap()
        app.tables.staticTexts["text view this is a test message"].tap()
        app.buttons["good"].tap()
        app.alerts["Alert Message"].collectionViews.buttons["OK"].tap()
        
    }
    
}
