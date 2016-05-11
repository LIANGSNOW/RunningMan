//
//  LoginViewTest.swift
//  RunningMan
//
//  Created by zz on 5/11/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import XCTest
import UIKit

class LoginViewTest: XCTestCase {
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.

    }
    
    func testLoginFunction(){
        
        let app = XCUIApplication()
        let accountElementsQuery = app.otherElements.containingType(.StaticText, identifier:"Account")
        accountElementsQuery.childrenMatchingType(.TextField).element.tap()
        accountElementsQuery.childrenMatchingType(.TextField).element
        
        let secureTextField = accountElementsQuery.childrenMatchingType(.SecureTextField).element
        secureTextField.tap()
        secureTextField.tap()
        accountElementsQuery.childrenMatchingType(.SecureTextField).element
        app.buttons["Login"].tap()
        
    }
    
    func testIfLoginWithUnexistedUserAccount(){
        
        let app = XCUIApplication()
        let accountElementsQuery = app.otherElements.containingType(.StaticText, identifier:"Account")
        accountElementsQuery.childrenMatchingType(.TextField).element.tap()
        accountElementsQuery.childrenMatchingType(.TextField).element
        let secureTextField = accountElementsQuery.childrenMatchingType(.SecureTextField).element
        secureTextField.tap()
        secureTextField.tap()
        accountElementsQuery.childrenMatchingType(.SecureTextField).element
        app.buttons["Login"].tap()
        app.alerts["Alert Message"].collectionViews.buttons["OK"].tap()
        
    }
    
    func testIfLoginWithIncorrectMessage(){
        
        let app = XCUIApplication()
        let accountElementsQuery = app.otherElements.containingType(.StaticText, identifier:"Account")
        accountElementsQuery.childrenMatchingType(.TextField).element.tap()
        accountElementsQuery.childrenMatchingType(.TextField).element
        app.otherElements.containingType(.StaticText, identifier:"Account").element.tap()
        
        let secureTextField = accountElementsQuery.childrenMatchingType(.SecureTextField).element
        secureTextField.tap()
        secureTextField.tap()
        accountElementsQuery.childrenMatchingType(.SecureTextField).element
        app.buttons["Login"].tap()
        app.alerts["Alert Message"].collectionViews.buttons["OK"].tap()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

}
