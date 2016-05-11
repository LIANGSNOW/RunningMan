//
//  UserInfoViewTest.swift
//  RunningMan
//
//  Created by zz on 5/11/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import XCTest

class UserInfoViewTest: XCTestCase {
        
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
    
    func testGetUserInfoFunction() {
        
        let app = XCUIApplication()
        app.buttons["Login"].tap()
        app.navigationBars["RunningMan.MainView"].buttons["Setting"].tap()
        app.buttons["Select a title image"].tap()
        app.collectionViews["PhotosGridView"].cells["Photo, Landscape, May 09, 10:36 PM"].tap()
        
        let element = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        element.childrenMatchingType(.TextField).elementBoundByIndex(3).tap()
        element.childrenMatchingType(.TextField).elementBoundByIndex(3)
        app.buttons["Confirm Change"].tap()
        
        let okButton = app.alerts["Alert Message"].collectionViews.buttons["OK"]
        okButton.tap()
        app.buttons["Change Password"].tap()
        element.childrenMatchingType(.SecureTextField).elementBoundByIndex(0).tap()
        element.childrenMatchingType(.SecureTextField).elementBoundByIndex(0)
        
        let secureTextField = element.childrenMatchingType(.SecureTextField).elementBoundByIndex(1)
        secureTextField.tap()
        secureTextField.tap()
        element.childrenMatchingType(.SecureTextField).elementBoundByIndex(1)
        
        let secureTextField2 = element.childrenMatchingType(.SecureTextField).elementBoundByIndex(2)
        secureTextField2.tap()
        secureTextField2.tap()
        element.childrenMatchingType(.SecureTextField).elementBoundByIndex(2)
        app.buttons["Confirm"].tap()
        okButton.tap()
        app.navigationBars["Title"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        app.navigationBars["RunningMan.UserInfoView"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        
    }
    
}
