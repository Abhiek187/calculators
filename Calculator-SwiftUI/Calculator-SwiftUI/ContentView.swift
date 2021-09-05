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
            .padding()
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
    @State var numStr = ""
    @State var output = ""
    internal var didAppear: ((Self) -> Void)? // for unit testing
    
    func clearOutput() {
        numStr = ""
        num1 = 0.0
        op = ""
        output = ""
    }
    
    func addNumber(key: String) {
        numStr += key
        output += key
    }
    
    func addOperator(key: String) {
        guard let num = Double(numStr) else { return }
        num1 = num
        op = key
        numStr = ""
        output += " \(key) "
    }
    
    func invertNumber() {
        if numStr.starts(with: "-") {
            let index = numStr.index(numStr.startIndex, offsetBy: 1)
            numStr = String(numStr[index...])
        } else {
            numStr = "-\(numStr)"
        }
        
        output = numStr
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
        VStack {
            Text(output)
                .font(.largeTitle)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .modifier(FillScreen(alignment: .trailing))
                
            HStack {
                Button(action: {
                    addOperator(key: "^")
                }) {
                    Text("^")
                        .round()
                }
                .round(color: Color.secondary)
                
                Spacer()
                
                Button(action: {}) {
                    Text("π")
                        .round()
                }
                .round(color: Color.secondary)
                .disabled(true)
                
                Spacer()
                
                Button(action: {}) {
                    Text("ln")
                        .round()
                }
                .round(color: Color.secondary)
                .disabled(true)
                
                Spacer()
                
                Button(action: {
                    clearOutput()
                }) {
                    Text("clear")
                        .round()
                }
                .round(color: Color.systemRed)
            }
            .modifier(FillScreen())
            
            HStack {
                Button(action: {}) {
                    Text("(")
                        .round()
                }
                .round(color: Color.secondary)
                .disabled(true)
                
                Spacer()
                
                Button(action: {}) {
                    Text(")")
                        .round()
                }
                .round(color: Color.secondary)
                .disabled(true)
                
                Spacer()
                
                Button(action: {
                    addOperator(key: "%")
                }) {
                    Text("%")
                        .round()
                }
                .round(color: Color.systemGreen)
                
                Spacer()
                
                Button(action: {
                    addOperator(key: "/")
                }) {
                    Text("/")
                        .round()
                }
                .round(color: Color.systemGreen)
            }
            .modifier(FillScreen())
            
            HStack {
                Button(action: {
                    addNumber(key: "7")
                }) {
                    Text("7")
                        .round()
                }
                .round(color: Color.systemOrange)
                
                Spacer()
                
                Button(action: {
                    addNumber(key: "8")
                }) {
                    Text("8")
                        .round()
                }
                .round(color: Color.systemOrange)
                
                Spacer()
                
                Button(action: {
                    addNumber(key: "9")
                }) {
                    Text("9")
                        .round()
                }
                .round(color: Color.systemOrange)
                
                Spacer()
                
                Button(action: {
                    addOperator(key: "*")
                }) {
                    Text("*")
                        .round()
                }
                .round(color: Color.systemGreen)
            }
            .modifier(FillScreen())
            
            HStack {
                Button(action: {
                    addNumber(key: "4")
                }) {
                    Text("4")
                        .round()
                }
                .round(color: Color.systemOrange)
                
                Spacer()
                
                Button(action: {
                    addNumber(key: "5")
                }) {
                    Text("5")
                        .round()
                }
                .round(color: Color.systemOrange)
                
                Spacer()
                
                Button(action: {
                    addNumber(key: "6")
                }) {
                    Text("6")
                        .round()
                }
                .round(color: Color.systemOrange)
                
                Spacer()
                
                Button(action: {
                    addOperator(key: "-")
                }) {
                    Text("-")
                        .round()
                }
                .round(color: Color.systemGreen)
            }
            .modifier(FillScreen())
            
            HStack {
                Button(action: {
                    addNumber(key: "1")
                }) {
                    Text("1")
                        .round()
                }
                .round(color: Color.systemOrange)
                
                Spacer()
                
                Button(action: {
                    addNumber(key: "2")
                }) {
                    Text("2")
                        .round()
                }
                .round(color: Color.systemOrange)
                
                Spacer()
                
                Button(action: {
                    addNumber(key: "3")
                }) {
                    Text("3")
                        .round()
                }
                .round(color: Color.systemOrange)
                
                Spacer()
                
                Button(action: {
                    addOperator(key: "+")
                }) {
                    Text("+")
                        .round()
                }
                .round(color: Color.systemGreen)
            }
            .modifier(FillScreen())
            
            HStack {
                Button(action: {
                    addNumber(key: "0")
                }) {
                    Text("0")
                        .round()
                }
                .round(color: Color.systemOrange)
                
                Spacer()
                
                Button(action: {
                    addNumber(key: ".")
                }) {
                    Text(".")
                        .round()
                }
                .round(color: Color.secondary)
                
                Spacer()
                
                Button(action: {
                    invertNumber()
                }) {
                    Text("(-)")
                        .round()
                }
                .round(color: Color.secondary)
                
                Spacer()
                
                Button(action: {
                    evaluate()
                }) {
                    Text("=")
                        .round()
                }
                .round(color: Color.systemBlue)
            }
            .modifier(FillScreen())
        }
        .modifier(FillScreen())
        .onAppear { self.didAppear?(self) }
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
