//
//  Calculator_SwiftUITests.swift
//  Calculator-SwiftUITests
//
//  Created by Basanta Chaudhuri on 5/20/21.
//

import ViewInspector // library to handle unit testing in SwiftUI (https://github.com/nalexn/ViewInspector)
import XCTest
@testable import Calculator_SwiftUI

extension ContentView: Inspectable {}

class Calculator_SwiftUITests: XCTestCase {
    var contentView: ContentView! // system under test

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        contentView = ContentView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        contentView = nil
        try super.tearDownWithError()
    }
    
    func inspectWrapper(testBlock: @escaping (ContentView) -> Void) {
        let exp = contentView.on(\.didAppear) { view in
            let sut = try view.actualView()
            testBlock(sut) // code block for testing
        }
        
        ViewHosting.host(view: contentView)
        wait(for: [exp], timeout: 0.1)
    }
    
    func testAddNumber_Integer() {
        inspectWrapper { sut in
            sut.addNumber(key: "7")
            sut.addNumber(key: "2")
            sut.addNumber(key: "9")

            XCTAssertEqual(sut.numStr, "729")
            XCTAssertEqual(sut.output, "729")
        }
    }
    
    func testAddNumber_Decimal() {
        inspectWrapper { sut in
            sut.addNumber(key: "3")
            sut.addNumber(key: ".")
            sut.addNumber(key: "1")
            sut.addNumber(key: "4")

            XCTAssertEqual(sut.numStr, "3.14")
            XCTAssertEqual(sut.output, "3.14")
        }
    }

    func testAddOperator_Valid() {
        inspectWrapper { sut in
            sut.addNumber(key: "2")
            sut.addNumber(key: "1")
            sut.addOperator(key: "%")

            XCTAssertEqual(sut.num1, 21.0, accuracy: Double.ulpOfOne)
            XCTAssertEqual(sut.op, "%")
            XCTAssertTrue(sut.numStr.isEmpty)
            XCTAssertEqual(sut.output, "21 % ")
        }
    }

    func testAddOperator_Invalid() {
        inspectWrapper { sut in
            sut.addOperator(key: "+")

            XCTAssertEqual(sut.num1, 0.0, accuracy: Double.ulpOfOne)
            XCTAssertTrue(sut.op.isEmpty)
            XCTAssertTrue(sut.numStr.isEmpty)
            XCTAssertTrue(sut.output.isEmpty)
        }
    }

    func testInvertNumber_Empty() {
        inspectWrapper { sut in
            sut.invertNumber()

            XCTAssertEqual(sut.numStr, "-")
            XCTAssertEqual(sut.output, "-")
        }
    }

    func testInvertNumber_Once() {
        inspectWrapper { sut in
            sut.addNumber(key: "5")
            sut.addNumber(key: "4")
            sut.invertNumber()

            XCTAssertEqual(sut.numStr, "-54")
            XCTAssertEqual(sut.output, "-54")
        }
    }

    func testInvertNumber_Twice() {
        inspectWrapper { sut in
            sut.addNumber(key: "5")
            sut.invertNumber()
            sut.addNumber(key: "4")
            sut.invertNumber()

            XCTAssertEqual(sut.numStr, "54")
            XCTAssertEqual(sut.output, "54")
        }
    }

    func testEvaluate_ValidAdd() {
        inspectWrapper { sut in
            sut.addNumber(key: "2")
            sut.addOperator(key: "+")
            sut.addNumber(key: "3")
            sut.evaluate()

            XCTAssertEqual(sut.num1, 5.0, accuracy: Double.ulpOfOne)
            XCTAssertTrue(sut.op.isEmpty)
            XCTAssertEqual(sut.numStr, "5.0")
            XCTAssertEqual(sut.output, "5.0")
        }
    }

    func testEvaluate_ValidSubtract() {
        inspectWrapper { sut in
            sut.addNumber(key: "2")
            sut.addOperator(key: "-")
            sut.addNumber(key: "3")
            sut.evaluate()

            XCTAssertEqual(sut.num1, -1.0, accuracy: Double.ulpOfOne)
            XCTAssertTrue(sut.op.isEmpty)
            XCTAssertEqual(sut.numStr, "-1.0")
            XCTAssertEqual(sut.output, "-1.0")
        }
    }

    func testEvaluate_ValidMultiply() {
        inspectWrapper { sut in
            sut.addNumber(key: "2")
            sut.addOperator(key: "*")
            sut.addNumber(key: "3")
            sut.evaluate()

            XCTAssertEqual(sut.num1, 6.0, accuracy: Double.ulpOfOne)
            XCTAssertTrue(sut.op.isEmpty)
            XCTAssertEqual(sut.numStr, "6.0")
            XCTAssertEqual(sut.output, "6.0")
        }
    }

    func testEvaluate_ValidDivide() {
        inspectWrapper { sut in
            sut.addNumber(key: "2")
            sut.addOperator(key: "/")
            sut.addNumber(key: "3")
            sut.evaluate()
            let answer = 2/3.0

            XCTAssertEqual(sut.num1, answer, accuracy: Double.ulpOfOne)
            XCTAssertTrue(sut.op.isEmpty)
            XCTAssertEqual(sut.numStr, String(answer))
            XCTAssertEqual(sut.output, String(answer))
        }
    }

    func testEvaluate_ValidMod() {
        inspectWrapper { sut in
            sut.addNumber(key: "2")
            sut.addOperator(key: "%")
            sut.addNumber(key: "3")
            sut.evaluate()

            XCTAssertEqual(sut.num1, 2.0, accuracy: Double.ulpOfOne)
            XCTAssertTrue(sut.op.isEmpty)
            XCTAssertEqual(sut.numStr, "2.0")
            XCTAssertEqual(sut.output, "2.0")
        }
    }

    func testEvaluate_ValidExp() {
        inspectWrapper { sut in
            sut.addNumber(key: "2")
            sut.addOperator(key: "^")
            sut.addNumber(key: "3")
            sut.evaluate()

            XCTAssertEqual(sut.num1, 8.0, accuracy: Double.ulpOfOne)
            XCTAssertTrue(sut.op.isEmpty)
            XCTAssertEqual(sut.numStr, "8.0")
            XCTAssertEqual(sut.output, "8.0")
        }
    }

    func testEvaluate_MissingFirstNum() {
        inspectWrapper { sut in
            sut.evaluate()

            XCTAssertEqual(sut.num1, 0.0, accuracy: Double.ulpOfOne)
            XCTAssertTrue(sut.op.isEmpty)
            XCTAssertTrue(sut.numStr.isEmpty)
            XCTAssertTrue(sut.output.isEmpty)
        }
    }

    func testEvaluate_MissingOperator() {
        inspectWrapper { sut in
            sut.addNumber(key: "2")
            sut.evaluate()

            XCTAssertEqual(sut.num1, 2.0, accuracy: Double.ulpOfOne)
            XCTAssertTrue(sut.op.isEmpty)
            XCTAssertEqual(sut.numStr, "2.0")
            XCTAssertEqual(sut.output, "2.0")
        }
    }

    func testEvaluate_MissingSecondNum() {
        inspectWrapper { sut in
            sut.addNumber(key: "2")
            sut.addOperator(key: "^")
            sut.evaluate()

            XCTAssertEqual(sut.num1, 2.0, accuracy: Double.ulpOfOne)
            XCTAssertEqual(sut.op, "^")
            XCTAssertTrue(sut.numStr.isEmpty)
            XCTAssertEqual(sut.output, "2 ^ ")
        }
    }

    func testClearOutput_Empty() {
        inspectWrapper { sut in
            sut.clearOutput()

            XCTAssertTrue(sut.numStr.isEmpty)
            XCTAssertEqual(sut.num1, 0.0, accuracy: Double.ulpOfOne)
            XCTAssertTrue(sut.op.isEmpty)
            XCTAssertTrue(sut.output.isEmpty)
        }
    }

    func testClearOutput_AfterFirstNum() {
        inspectWrapper { sut in
            sut.addNumber(key: "6")
            sut.clearOutput()

            XCTAssertTrue(sut.numStr.isEmpty)
            XCTAssertEqual(sut.num1, 0.0, accuracy: Double.ulpOfOne)
            XCTAssertTrue(sut.op.isEmpty)
            XCTAssertTrue(sut.output.isEmpty)
        }
    }

    func testClearOutput_AfterOperator() {
        inspectWrapper { sut in
            sut.addNumber(key: "6")
            sut.addOperator(key: "/")
            sut.clearOutput()

            XCTAssertTrue(sut.numStr.isEmpty)
            XCTAssertEqual(sut.num1, 0.0, accuracy: Double.ulpOfOne)
            XCTAssertTrue(sut.op.isEmpty)
            XCTAssertTrue(sut.output.isEmpty)
        }
    }

    func testClearOutput_AfterSecondNum() {
        inspectWrapper { sut in
            sut.addNumber(key: "6")
            sut.addOperator(key: "/")
            sut.addNumber(key: "6")
            sut.clearOutput()

            XCTAssertTrue(sut.numStr.isEmpty)
            XCTAssertEqual(sut.num1, 0.0, accuracy: Double.ulpOfOne)
            XCTAssertTrue(sut.op.isEmpty)
            XCTAssertTrue(sut.output.isEmpty)
        }
    }

    func testClearOutput_AfterEvaluate() {
        inspectWrapper { sut in
            sut.addNumber(key: "6")
            sut.addOperator(key: "/")
            sut.addNumber(key: "6")
            sut.evaluate()
            sut.clearOutput()

            XCTAssertTrue(sut.numStr.isEmpty)
            XCTAssertEqual(sut.num1, 0.0, accuracy: Double.ulpOfOne)
            XCTAssertTrue(sut.op.isEmpty)
            XCTAssertTrue(sut.output.isEmpty)
        }
    }
}
