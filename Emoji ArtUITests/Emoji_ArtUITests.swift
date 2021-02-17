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
        print(app.debugDescription)
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }
    

    // helperfunction to get a random string
    // quelle: https://stackoverflow.com/questions/26845307/generate-random-alphanumeric-string-in-swift
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyz"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
    func testNameChange() throws {
        
        let addButton = app.buttons["AddButton"]
        let editDoneButton = app.buttons["EditDoneButton"]
        let List = app.tables["List"]
 
        //add drücken
        addButton.tap()
        
        //edit drücken
        editDoneButton.tap()
        
        // Check if Editbutton Label has changed
        XCTAssertEqual("Done", editDoneButton.label)
        
        
        // Press on the first Cell to Edit
        List.cells.allElementsBoundByIndex.first?.tap()

        // Add Random Character to Document Name
        let randomChar1 = randomString(length: 1)
        app.keys[randomChar1].tap()
        
        let randomChar2 = randomString(length: 1)
        app.keys[randomChar2].tap()

        // Press Done Buttom & Check if Label has Changed
        editDoneButton.tap()
        XCTAssertEqual("Edit", editDoneButton.label)
        
        // Check if Cell with new DocumentName exists
        let renamedCell = app.tables.cells["Untitled" + randomChar1 + randomChar2]
        XCTAssertTrue(renamedCell.exists)
        

    }


}
