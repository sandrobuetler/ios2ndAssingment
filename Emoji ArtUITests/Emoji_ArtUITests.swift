//
//  Emoji_ArtUITests.swift
//  Emoji ArtUITests
//
//  Created by Sandro Bütler on 16.02.21.
//  Copyright © 2021 fhnw. All rights reserved.
//

import XCTest
//quelle: https://www.youtube.com/watch?v=-eiY9eauJr0&ab_channel=iOSAcademy
@testable import Emoji_Art

class Emoji_ArtUITests: XCTestCase {
    
    
    //var app: XCUIApplication

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //quelle: https://www.swiftbysundell.com/articles/getting-started-with-xcode-ui-testing-in-swift/
        super.setUp()
        
        //app = XCUIApplication()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        //app.launchArguments.append("--iutesting")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNameChange() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let editDoneButton = app.buttons["EditDoneButton"]
        //textfeld kann nicht angesprochen werden
        let documentName = app.textFields["DocumentName"]
        

        //edit drücken
        editDoneButton.tap()
        
        XCTAssertEqual("Done", editDoneButton.label)
        
        
        //documentName.typeText("Dokumentname")
        
        editDoneButton.tap()
        
        XCTAssertEqual("Edit", editDoneButton.label)
        // XCTAssertEqual("Dokumentname", documentName.label)
 
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
