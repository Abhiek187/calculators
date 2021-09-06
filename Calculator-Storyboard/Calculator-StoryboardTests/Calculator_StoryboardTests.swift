//
//  Calculator_StoryboardTests.swift
//  Calculator-StoryboardTests
//
//  Created by Basanta Chaudhuri on 5/19/21.
//

import XCTest
@testable import Calculator_Storyboard

class Calculator_StoryboardTests: XCTestCase {
    var sut: ViewController! // system under test

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = ViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }
    
    func testAddNumber_Integer() {
        sut.addNumber(key: "7")
        sut.addNumber(key: "2")
        sut.addNumber(key: "9")

        XCTAssertEqual(sut.numStr, "729")
    }
    
    func testAddNumber_Decimal() {
        sut.addNumber(key: "3")
        sut.addNumber(key: ".")
        sut.addNumber(key: "1")
        sut.addNumber(key: "4")

        XCTAssertEqual(sut.numStr, "3.14")
    }
    
    func testAddOperator_Valid() {
        sut.addNumber(key: "2")
        sut.addNumber(key: "1")
        sut.addOperator(key: "%")

        XCTAssertEqual(sut.num1, 21.0, accuracy: Double.ulpOfOne)
        XCTAssertEqual(sut.op, "%")
        XCTAssertTrue(sut.numStr.isEmpty)
    }
    
    func testAddOperator_Empty() {
        sut.addOperator(key: "+")

        XCTAssertEqual(sut.num1, 0.0, accuracy: Double.ulpOfOne)
        XCTAssertEqual(sut.op, "+")
        XCTAssertTrue(sut.numStr.isEmpty)
    }
    
    func testInvertNumber_Empty() {
        sut.invertNumber()

        XCTAssertEqual(sut.numStr, "-0")
    }
    
    func testInvertNumber_Once() {
        sut.addNumber(key: "5")
        sut.addNumber(key: "4")
        sut.invertNumber()

        XCTAssertEqual(sut.numStr, "-54")
    }
    
    func testInvertNumber_Twice() {
        sut.addNumber(key: "5")
        sut.invertNumber()
        sut.addNumber(key: "4")
        sut.invertNumber()

        XCTAssertEqual(sut.numStr, "54")
    }
    
    func testEvaluate_ValidAdd() {
        sut.addNumber(key: "2")
        sut.addOperator(key: "+")
        sut.addNumber(key: "3")
        sut.evaluate()

        XCTAssertEqual(sut.num1, 5.0, accuracy: Double.ulpOfOne)
        XCTAssertTrue(sut.op.isEmpty)
        XCTAssertEqual(sut.numStr, "5.0")
    }
    
    func testEvaluate_ValidSubtract() {
        sut.addNumber(key: "2")
        sut.addOperator(key: "-")
        sut.addNumber(key: "3")
        sut.evaluate()

        XCTAssertEqual(sut.num1, -1.0, accuracy: Double.ulpOfOne)
        XCTAssertTrue(sut.op.isEmpty)
        XCTAssertEqual(sut.numStr, "-1.0")
    }

    func testEvaluate_ValidMultiply() {
        sut.addNumber(key: "2")
        sut.addOperator(key: "*")
        sut.addNumber(key: "3")
        sut.evaluate()

        XCTAssertEqual(sut.num1, 6.0, accuracy: Double.ulpOfOne)
        XCTAssertTrue(sut.op.isEmpty)
        XCTAssertEqual(sut.numStr, "6.0")
    }
    
    func testEvaluate_ValidDivide() {
        sut.addNumber(key: "2")
        sut.addOperator(key: "/")
        sut.addNumber(key: "3")
        sut.evaluate()
        let answer = 2/3.0

        XCTAssertEqual(sut.num1, answer, accuracy: Double.ulpOfOne)
        XCTAssertTrue(sut.op.isEmpty)
        XCTAssertEqual(sut.numStr, String(answer))
    }

    func testEvaluate_ValidMod() {
        sut.addNumber(key: "2")
        sut.addOperator(key: "%")
        sut.addNumber(key: "3")
        sut.evaluate()

        XCTAssertEqual(sut.num1, 2.0, accuracy: Double.ulpOfOne)
        XCTAssertTrue(sut.op.isEmpty)
        XCTAssertEqual(sut.numStr, "2.0")
    }
    
    func testEvaluate_ValidExp() {
        sut.addNumber(key: "2")
        sut.addOperator(key: "^")
        sut.addNumber(key: "3")
        sut.evaluate()

        XCTAssertEqual(sut.num1, 8.0, accuracy: Double.ulpOfOne)
        XCTAssertTrue(sut.op.isEmpty)
        XCTAssertEqual(sut.numStr, "8.0")
    }
    
    func testEvaluate_MissingFirstNum() {
        sut.evaluate()

        XCTAssertEqual(sut.num1, 0.0, accuracy: Double.ulpOfOne)
        XCTAssertTrue(sut.op.isEmpty)
        XCTAssertEqual(sut.numStr, "0.0")
    }
    
    func testEvaluate_MissingOperator() {
        sut.addNumber(key: "2")
        sut.evaluate()

        XCTAssertEqual(sut.num1, 2.0, accuracy: Double.ulpOfOne)
        XCTAssertTrue(sut.op.isEmpty)
        XCTAssertEqual(sut.numStr, "2.0")
    }
    
    func testEvaluate_MissingSecondNum() {
        sut.addNumber(key: "2")
        sut.addOperator(key: "^")
        sut.evaluate()

        XCTAssertEqual(sut.num1, 2.0, accuracy: Double.ulpOfOne)
        XCTAssertEqual(sut.op, "^")
        XCTAssertTrue(sut.numStr.isEmpty)
    }
    
    func testClearOutput_Empty() {
        sut.clearOutput()

        XCTAssertEqual(sut.numStr, "0")
        XCTAssertEqual(sut.num1, 0.0, accuracy: Double.ulpOfOne)
        XCTAssertTrue(sut.op.isEmpty)
    }
    
    func testClearOutput_AfterFirstNum() {
        sut.addNumber(key: "6")
        sut.clearOutput()

        XCTAssertEqual(sut.numStr, "0")
        XCTAssertEqual(sut.num1, 0.0, accuracy: Double.ulpOfOne)
        XCTAssertTrue(sut.op.isEmpty)
    }
    
    func testClearOutput_AfterOperator() {
        sut.addNumber(key: "6")
        sut.addOperator(key: "/")
        sut.clearOutput()

        XCTAssertEqual(sut.numStr, "0")
        XCTAssertEqual(sut.num1, 0.0, accuracy: Double.ulpOfOne)
        XCTAssertTrue(sut.op.isEmpty)
    }
    
    func testClearOutput_AfterSecondNum() {
        sut.addNumber(key: "6")
        sut.addOperator(key: "/")
        sut.addNumber(key: "6")
        sut.clearOutput()

        XCTAssertEqual(sut.numStr, "0")
        XCTAssertEqual(sut.num1, 0.0, accuracy: Double.ulpOfOne)
        XCTAssertTrue(sut.op.isEmpty)
    }

    func testClearOutput_AfterEvaluate() {
        sut.addNumber(key: "6")
        sut.addOperator(key: "/")
        sut.addNumber(key: "6")
        sut.evaluate()
        sut.clearOutput()

        XCTAssertEqual(sut.numStr, "0")
        XCTAssertEqual(sut.num1, 0.0, accuracy: Double.ulpOfOne)
        XCTAssertTrue(sut.op.isEmpty)
    }
}
