//
//  ViewController.swift
//  Calculator-Storyboard
//
//  Created by Basanta Chaudhuri on 5/19/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var labelOutput: UILabel!
    
    @IBOutlet weak var buttonExponent: UIButton!
    @IBOutlet weak var buttonPi: UIButton!
    @IBOutlet weak var buttonLn: UIButton!
    @IBOutlet weak var buttonClear: UIButton!
    
    @IBOutlet weak var buttonParenLeft: UIButton!
    @IBOutlet weak var buttonParenRight: UIButton!
    @IBOutlet weak var buttonMod: UIButton!
    @IBOutlet weak var buttonDivide: UIButton!
    
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var buttonMultiply: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var buttonDot: UIButton!
    @IBOutlet weak var buttonNegative: UIButton!
    @IBOutlet weak var buttonEquals: UIButton!
    
    // MARK: Local Variables
    var num1 = 0.0
    var op = ""
    var numStr = "0"
    
    // MARK: Functions and Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func clearOutput() {
        numStr = "0"
        num1 = 0.0
        op = ""
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
    }
    
    func addOperator(key: String) {
        guard let num = Double(numStr) else { return }
        num1 = num
        op = key
        numStr = ""
    }
    
    func invertNumber() {
        if numStr.starts(with: "-") {
            let index = numStr.index(numStr.startIndex, offsetBy: 1)
            numStr = String(numStr[index...])
        } else {
            numStr = "-\(numStr)"
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
    }
    
    private func opButtonPressed(key: String) {
        addOperator(key: key)
        labelOutput.text?.append(" \(key) ")
    }
    
    private func numButtonPressed(key: String) {
        addNumber(key: key)
        
        if labelOutput.text == "0" {
            labelOutput.text = key
        } else if labelOutput.text == "-0" {
            labelOutput.text = "-\(key)"
        } else {
            labelOutput.text?.append(key)
        }
    }

    // MARK: IBActions
    @IBAction func tappedButtonExponent(_ sender: UIButton) {
        opButtonPressed(key: "^")
    }
    
    @IBAction func tappedButtonPi(_ sender: UIButton) {
        sender.isEnabled = false
    }
    
    @IBAction func tappedButtonLn(_ sender: UIButton) {
        sender.isEnabled = false
    }
    
    @IBAction func tappedButtonClear(_ sender: UIButton) {
        clearOutput()
        labelOutput.text = "0"
    }
    
    @IBAction func tappedButtonParenLeft(_ sender: UIButton) {
        sender.isEnabled = false
    }
    
    @IBAction func tappedButtonParenRight(_ sender: UIButton) {
        sender.isEnabled = false
    }
    
    @IBAction func tappedButtonMod(_ sender: UIButton) {
        opButtonPressed(key: "%")
    }
    
    @IBAction func tappedButtonDivide(_ sender: UIButton) {
        opButtonPressed(key: "/")
    }
    
    @IBAction func tappedButton7(_ sender: UIButton) {
        numButtonPressed(key: "7")
    }
    
    @IBAction func tappedButton8(_ sender: UIButton) {
        numButtonPressed(key: "8")
    }
    
    @IBAction func tappedButton9(_ sender: UIButton) {
        numButtonPressed(key: "9")
    }
    
    @IBAction func tappedButtonMultiply(_ sender: UIButton) {
        opButtonPressed(key: "*")
    }
    
    @IBAction func tappedButton4(_ sender: UIButton) {
        numButtonPressed(key: "4")
    }
    
    @IBAction func tappedButton5(_ sender: UIButton) {
        numButtonPressed(key: "5")
    }
    
    @IBAction func tappedButton6(_ sender: UIButton) {
        numButtonPressed(key: "6")
    }
    
    @IBAction func tappedButtonMinus(_ sender: UIButton) {
        opButtonPressed(key: "-")
    }
    
    @IBAction func tappedButton1(_ sender: UIButton) {
        numButtonPressed(key: "1")
    }
    
    @IBAction func tappedButton2(_ sender: UIButton) {
        numButtonPressed(key: "2")
    }
    
    @IBAction func tappedButton3(_ sender: UIButton) {
        numButtonPressed(key: "3")
    }
    
    @IBAction func tappedButtonPlus(_ sender: UIButton) {
        opButtonPressed(key: "+")
    }
    
    @IBAction func tappedButton0(_ sender: UIButton) {
        numButtonPressed(key: "0")
    }
    
    @IBAction func tappedButtonDot(_ sender: UIButton) {
        addNumber(key: ".")
        labelOutput.text?.append(".")
    }
    
    @IBAction func tappedButtonNegative(_ sender: UIButton) {
        invertNumber()
        labelOutput.text = numStr
    }
    
    @IBAction func tappedButtonEquals(_ sender: UIButton) {
        evaluate()
        labelOutput.text = numStr
    }
}
