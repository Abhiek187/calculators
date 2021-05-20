//
//  Calculator_StoryboardUITests.swift
//  Calculator-StoryboardUITests
//
//  Created by Basanta Chaudhuri on 5/19/21.
//

import XCTest

class Calculator_StoryboardUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
        try super.tearDownWithError()
    }
    
    func testSimpleEquation() {
        let button2 = app.buttons["2"]
        let buttonPlus = app.buttons["+"]
        let button3 = app.buttons["3"]
        let buttonEquals = app.buttons["="]
        
        button2.tap()
        let labelOutput = app.staticTexts.firstMatch
        XCTAssertEqual(labelOutput.label, "2")
        buttonPlus.tap()
        XCTAssertEqual(labelOutput.label, "2 + ")
        button3.tap()
        XCTAssertEqual(labelOutput.label, "2 + 3")
        buttonEquals.tap()
        XCTAssertEqual(labelOutput.label, "5.0")
    }

    func testComplexEquation() {
        let buttonNegative = app.buttons["(-)"]
        let button0 = app.buttons["0"]
        let buttonDot = app.buttons["."]
        let button1 = app.buttons["1"]
        let buttonMultiply = app.buttons["*"]
        let button7 = app.buttons["7"]
        let buttonEquals = app.buttons["="]
        let buttonDivide = app.buttons["/"]
        let button2 = app.buttons["2"]
        
        buttonNegative.tap()
        let labelOutput = app.staticTexts.firstMatch
        XCTAssertEqual(labelOutput.label, "-")
        button0.tap()
        XCTAssertEqual(labelOutput.label, "-0")
        buttonDot.tap()
        XCTAssertEqual(labelOutput.label, "-0.")
        button1.tap()
        XCTAssertEqual(labelOutput.label, "-0.1")
        buttonMultiply.tap()
        XCTAssertEqual(labelOutput.label, "-0.1 * ")
        button7.tap()
        XCTAssertEqual(labelOutput.label, "-0.1 * 7")
        buttonEquals.tap()
        XCTAssertEqual(labelOutput.label, "-0.7000000000000001")
        
        buttonDivide.tap()
        XCTAssertEqual(labelOutput.label, "-0.7000000000000001 / ")
        button2.tap()
        XCTAssertEqual(labelOutput.label, "-0.7000000000000001 / 2")
        buttonEquals.tap()
        XCTAssertEqual(labelOutput.label, "-0.35000000000000003")
    }
}
