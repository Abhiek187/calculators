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
    var numStr = ""
    
    // MARK: Functions and Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func clearOutput() {
        numStr = ""
        num1 = 0.0
        op = ""
    }
    
    func addNumber(key: String) {
        numStr += key
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

    // MARK: IBActions
    @IBAction func tappedButtonExponent(_ sender: UIButton) {
        addOperator(key: "^")
        labelOutput.text?.append(" ^ ")
    }
    
    @IBAction func tappedButtonPi(_ sender: UIButton) {
        sender.isEnabled = false
    }
    
    @IBAction func tappedButtonLn(_ sender: UIButton) {
        sender.isEnabled = false
    }
    
    @IBAction func tappedButtonClear(_ sender: UIButton) {
        clearOutput()
        labelOutput.text = ""
    }
    
    @IBAction func tappedButtonParenLeft(_ sender: UIButton) {
        sender.isEnabled = false
    }
    
    @IBAction func tappedButtonParenRight(_ sender: UIButton) {
        sender.isEnabled = false
    }
    
    @IBAction func tappedButtonMod(_ sender: UIButton) {
        addOperator(key: "%")
        labelOutput.text?.append(" % ")
    }
    
    @IBAction func tappedButtonDivide(_ sender: UIButton) {
        addOperator(key: "/")
        labelOutput.text?.append(" / ")
    }
    
    @IBAction func tappedButton7(_ sender: UIButton) {
        addNumber(key: "7")
        labelOutput.text?.append("7")
    }
    
    @IBAction func tappedButton8(_ sender: UIButton) {
        addNumber(key: "8")
        labelOutput.text?.append("8")
    }
    
    @IBAction func tappedButton9(_ sender: UIButton) {
        addNumber(key: "9")
        labelOutput.text?.append("9")
    }
    
    @IBAction func tappedButtonMultiply(_ sender: UIButton) {
        addOperator(key: "*")
        labelOutput.text?.append(" * ")
    }
    
    @IBAction func tappedButton4(_ sender: UIButton) {
        addNumber(key: "4")
        labelOutput.text?.append("4")
    }
    
    @IBAction func tappedButton5(_ sender: UIButton) {
        addNumber(key: "5")
        labelOutput.text?.append("5")
    }
    
    @IBAction func tappedButton6(_ sender: UIButton) {
        addNumber(key: "6")
        labelOutput.text?.append("6")
    }
    
    @IBAction func tappedButtonMinus(_ sender: UIButton) {
        addOperator(key: "-")
        labelOutput.text?.append(" - ")
    }
    
    @IBAction func tappedButton1(_ sender: UIButton) {
        addNumber(key: "1")
        labelOutput.text?.append("1")
    }
    
    @IBAction func tappedButton2(_ sender: UIButton) {
        addNumber(key: "2")
        labelOutput.text?.append("2")
    }
    
    @IBAction func tappedButton3(_ sender: UIButton) {
        addNumber(key: "3")
        labelOutput.text?.append("3")
    }
    
    @IBAction func tappedButtonPlus(_ sender: UIButton) {
        addOperator(key: "+")
        labelOutput.text?.append(" + ")
    }
    
    @IBAction func tappedButton0(_ sender: UIButton) {
        addNumber(key: "0")
        labelOutput.text?.append("0")
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
