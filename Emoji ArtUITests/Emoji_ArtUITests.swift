//
//  Emoji_ArtUITests.swift
//  Emoji ArtUITests
//
//  Created by Sandro Bütler on 16.02.21.
//  Copyright © 2021 fhnw. All rights reserved.
//

import XCTest

class Emoji_ArtUITests: XCTestCase {
    
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //quelle: https://www.swiftbysundell.com/articles/getting-started-with-xcode-ui-testing-in-swift/
        super.setUp()
        
        self.app = XCUIApplication()
        self.app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    func testNameChange() throws {
        // UI tests must launch the application that they test.
        
        
     let editDoneButton = app.buttons["EditDoneButton"]
        //textfeld kann nicht angesprochen werden
        //let documentName = app.textFields["DocumentName"]
        //let documentName = app.textFields["DocumentName"]
        
        let textArea = app.tables["List"]
 
        
        //edit drücken
       editDoneButton.tap()
        
        XCTAssertEqual("Done", editDoneButton.label)
        
       textArea.cells.allElementsBoundByIndex.first?.tap()
       app.keys["t"].tap()
       app.keys["e"].tap()
       app.keys["s"].tap()
       app.keys["t"].tap()
        //documentName.typeText("Dokumentname")
        
       editDoneButton.tap()
      XCTAssertEqual("Edit", editDoneButton.label)
      XCTAssertEqual("Untitledtest", textArea.cells.allElementsBoundByIndex.first?.label)
 
        
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
