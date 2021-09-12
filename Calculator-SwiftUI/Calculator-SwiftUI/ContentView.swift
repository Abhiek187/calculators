//
//  ContentView.swift
//  Calculator-SwiftUI
//
//  Created by Basanta Chaudhuri on 5/20/21.
//

import SwiftUI

struct FillScreen: ViewModifier {
    var alignment = Alignment.center
    
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: alignment)
            .padding(.horizontal)
            .padding(.vertical, 1)
    }
}

extension Color {
    // Colors that adapt to light and dark mode
    static let label = Color(UIColor.label)
    
    static let systemBlue = Color(UIColor.systemBlue)
    static let systemGreen = Color(UIColor.systemGreen)
    static let systemOrange = Color(UIColor.systemOrange)
    static let systemRed = Color(UIColor.systemRed)
}

extension Button {
    func round(color: Color) -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(color)
            )
    }
}

extension Text {
    // Fit text within a round button
    func round() -> some View {
        self
            .frame(width: 60, height: 60, alignment: .center)
            .foregroundColor(.label)
            .contentShape(
                RoundedRectangle(cornerRadius: 30)
            )
    }
}

struct ContentView: View {
    @State var num1 = 0.0
    @State var op = ""
    @State var numStr = "0"
    @State var output = "0"
    internal var didAppear: ((Self) -> Void)? // for unit testing
    
    func clearOutput() {
        numStr = "0"
        num1 = 0.0
        op = ""
        output = "0"
    }
    
    func addNumber(key: String) {
        // Replace a 0 with the number
        if numStr == "0" {
            numStr = key
        } else if numStr == "-0" {
            numStr = "-\(key)"
        } else {
            numStr += key
        }
        
        if output == "0" {
            output = key
        } else if output == "-0" {
            output = "-\(key)"
        } else {
            output += key
        }
    }
    
    func addDecimal() {
        // Don't add another decimal point if the number already contains one
        if !numStr.contains(".") {
            numStr += "."
            output += "."
        }
    }
    
    func addOperator(key: String) {
        // Simplify the left side of the expression before chaining additional operators
        evaluate()
        guard let num = Double(numStr) else { return }
        num1 = num
        op = key
        numStr = ""
        output = "\(num) \(key) "
    }
    
    func invertNumber() {
        if numStr.starts(with: "-") {
            let index = numStr.index(numStr.startIndex, offsetBy: 1)
            numStr = String(numStr[index...])
        } else {
            numStr = "-\(numStr)"
        }
        
        if !op.isEmpty {
            // Negate the right side of the expression
            output = "\(num1) \(op) \(numStr)"
        } else {
            output = numStr
        }
    }
    
    func backspace() {
        if !numStr.isEmpty {
            numStr.removeLast()

            if numStr.isEmpty {
                numStr = "0" // show 0 when there's no text
            }
        } else if !op.isEmpty {
            // Undo addOperator after deleting an operator
            numStr = String(num1)
            num1 = 0.0
            op = ""
        }
        
        if !output.isEmpty {
            let index = output.index(before: output.endIndex)

            if output[index..<output.endIndex] == " " {
                output.removeLast(3) // remove the spaces in between the operator
            } else {
                output.remove(at: index)
            }

            if output.isEmpty {
                output = "0"
            }
        }
    }
    
    func evaluate() {
        guard let num2 = Double(numStr) else { return }
        let result: Double
        
        switch op {
        case "+":
            result = num1 + num2
        case "-":
            result = num1 - num2
        case "*":
            result = num1 * num2
        case "/":
            result = num1 / num2
        case "%":
            result = num1.truncatingRemainder(dividingBy: num2)
        case "^":
            result = pow(num1, num2)
        default:
            result = num2
        }
        
        num1 = result
        numStr = String(result)
        op = ""
        output = numStr
    }
    
    var body: some View {
        GeometryReader { metrics in
            VStack(spacing: 0) {
                Text(output)
                    .font(.largeTitle)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: metrics.size.width * 0.9, height: metrics.size.height * 0.1, alignment: .trailing)
                    .padding()
                
                ScrollView {
                    HStack {
                        Button(action: {
                            addOperator(key: "^")
                        }) {
                            Text("^")
                                .round()
                        }
                        .round(color: .secondary)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("π")
                                .round()
                        }
                        .round(color: .secondary)
                        .disabled(true)
                        
                        Spacer()
                        
                        Button(action: {
                            backspace()
                        }) {
                            Text("↩︎")
                                .round()
                        }
                        .round(color: .systemRed)
                        
                        Spacer()
                        
                        Button(action: {
                            clearOutput()
                        }) {
                            Text("clear")
                                .round()
                        }
                        .round(color: .systemRed)
                    }
                    .modifier(FillScreen())
                    
                    HStack {
                        Button(action: {}) {
                            Text("(")
                                .round()
                        }
                        .round(color: .secondary)
                        .disabled(true)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text(")")
                                .round()
                        }
                        .round(color: .secondary)
                        .disabled(true)
                        
                        Spacer()
                        
                        Button(action: {
                            addOperator(key: "%")
                        }) {
                            Text("%")
                                .round()
                        }
                        .round(color: .systemGreen)
                        
                        Spacer()
                        
                        Button(action: {
                            addOperator(key: "/")
                        }) {
                            Text("/")
                                .round()
                        }
                        .round(color: .systemGreen)
                    }
                    .modifier(FillScreen())
                    
                    HStack {
                        Button(action: {
                            addNumber(key: "7")
                        }) {
                            Text("7")
                                .round()
                        }
                        .round(color: .systemOrange)
                        
                        Spacer()
                        
                        Button(action: {
                            addNumber(key: "8")
                        }) {
                            Text("8")
                                .round()
                        }
                        .round(color: .systemOrange)
                        
                        Spacer()
                        
                        Button(action: {
                            addNumber(key: "9")
                        }) {
                            Text("9")
                                .round()
                        }
                        .round(color: .systemOrange)
                        
                        Spacer()
                        
                        Button(action: {
                            addOperator(key: "*")
                        }) {
                            Text("*")
                                .round()
                        }
                        .round(color: .systemGreen)
                    }
                    .modifier(FillScreen())
                    
                    HStack {
                        Button(action: {
                            addNumber(key: "4")
                        }) {
                            Text("4")
                                .round()
                        }
                        .round(color: .systemOrange)
                        
                        Spacer()
                        
                        Button(action: {
                            addNumber(key: "5")
                        }) {
                            Text("5")
                                .round()
                        }
                        .round(color: .systemOrange)
                        
                        Spacer()
                        
                        Button(action: {
                            addNumber(key: "6")
                        }) {
                            Text("6")
                                .round()
                        }
                        .round(color: .systemOrange)
                        
                        Spacer()
                        
                        Button(action: {
                            addOperator(key: "-")
                        }) {
                            Text("-")
                                .round()
                        }
                        .round(color: .systemGreen)
                    }
                    .modifier(FillScreen())
                    
                    HStack {
                        Button(action: {
                            addNumber(key: "1")
                        }) {
                            Text("1")
                                .round()
                        }
                        .round(color: .systemOrange)
                        
                        Spacer()
                        
                        Button(action: {
                            addNumber(key: "2")
                        }) {
                            Text("2")
                                .round()
                        }
                        .round(color: .systemOrange)
                        
                        Spacer()
                        
                        Button(action: {
                            addNumber(key: "3")
                        }) {
                            Text("3")
                                .round()
                        }
                        .round(color: .systemOrange)
                        
                        Spacer()
                        
                        Button(action: {
                            addOperator(key: "+")
                        }) {
                            Text("+")
                                .round()
                        }
                        .round(color: .systemGreen)
                    }
                    .modifier(FillScreen())
                    
                    HStack {
                        Button(action: {
                            addNumber(key: "0")
                        }) {
                            Text("0")
                                .round()
                        }
                        .round(color: .systemOrange)
                        
                        Spacer()
                        
                        Button(action: {
                            addDecimal()
                        }) {
                            Text(".")
                                .round()
                        }
                        .round(color: .secondary)
                        
                        Spacer()
                        
                        Button(action: {
                            invertNumber()
                        }) {
                            Text("(-)")
                                .round()
                        }
                        .round(color: .secondary)
                        
                        Spacer()
                        
                        Button(action: {
                            evaluate()
                        }) {
                            Text("=")
                                .round()
                        }
                        .round(color: .systemBlue)
                    }
                    .modifier(FillScreen())
                }
                .frame(minHeight: 0, maxHeight: .infinity)
            }
            .onAppear { self.didAppear?(self) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().preferredColorScheme(.light)
            ContentView().preferredColorScheme(.dark)
        }
    }
}
