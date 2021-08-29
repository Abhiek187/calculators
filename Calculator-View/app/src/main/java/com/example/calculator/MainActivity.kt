package com.example.calculator

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.calculator.databinding.ActivityMainBinding
import java.util.*


class MainActivity : AppCompatActivity() {
    // Create a stack for the numbers and operators
    val numbers = Stack<Double>()
    val operators = Stack<Char>()
    var numStr = "" // string to build up a number

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        with (binding) {
            // Implement all the button click listeners
            buttonExponent.setOnClickListener {
                // a ^ b
                addOperator('^')
                textViewOutput.append(" ^ ")
            }

            buttonPi.setOnClickListener {
                // pi
                it.isEnabled = false
            }

            buttonLn.setOnClickListener {
                // ln
                it.isEnabled = false
            }

            buttonClear.setOnClickListener {
                // Clear the output
                clearOutput()
                textViewOutput.text = ""
            }

            buttonParenLeft.setOnClickListener {
                // (
                it.isEnabled = false
            }

            buttonParenRight.setOnClickListener {
                // )
                it.isEnabled = false
            }

            buttonMod.setOnClickListener {
                // a % b
                addOperator('%')
                textViewOutput.append(" % ")
            }

            buttonDivide.setOnClickListener {
                // a / b
                addOperator('/')
                textViewOutput.append(" / ")
            }

            button7.setOnClickListener {
                // 7
                addNumber('7')
                textViewOutput.append("7")
            }

            button8.setOnClickListener {
                // 8
                addNumber('8')
                textViewOutput.append("8")
            }

            button9.setOnClickListener {
                // 9
                addNumber('9')
                textViewOutput.append("9")
            }

            buttonMultiply.setOnClickListener {
                // *
                addOperator('*')
                textViewOutput.append(" * ")
            }

            button4.setOnClickListener {
                // 4
                addNumber('4')
                textViewOutput.append("4")
            }

            button5.setOnClickListener {
                // 5
                addNumber('5')
                textViewOutput.append("5")
            }

            button6.setOnClickListener {
                // 6
                addNumber('6')
                textViewOutput.append("6")
            }

            buttonMinus.setOnClickListener {
                // a - b
                addOperator('-')
                textViewOutput.append(" - ")
            }

            button1.setOnClickListener {
                // 1
                addNumber('1')
                textViewOutput.append("1")
            }

            button2.setOnClickListener {
                // 2
                addNumber('2')
                textViewOutput.append("2")
            }

            button3.setOnClickListener {
                // 3
                addNumber('3')
                textViewOutput.append("3")
            }

            buttonPlus.setOnClickListener {
                // a + b
                addOperator('+')
                textViewOutput.append(" + ")
            }

            button0.setOnClickListener {
                // 0
                addNumber('0')
                textViewOutput.append("0")
            }

            buttonDot.setOnClickListener {
                // Add a decimal point to the number
                addNumber('.')
                textViewOutput.append(".")
            }

            buttonNegative.setOnClickListener {
                // Invert the sign of the number
                invertNumber()
                textViewOutput.text = numStr
            }

            buttonEquals.setOnClickListener {
                // Evaluate the expression
                evaluate()
                textViewOutput.text = numStr
            }
        }
    }

    fun clearOutput() {
        numStr = ""
        numbers.removeAllElements()
        operators.removeAllElements()
    }

    fun addNumber(key: Char) {
        numStr += key
    }

    fun addOperator(key: Char) {
        if (numStr.isEmpty()) return

        numbers.push(numStr.toDouble())
        operators.push(key)
        numStr = ""
    }

    fun invertNumber() {
        numStr = if (numStr.startsWith("-")) {
            numStr.substring(1)
        } else {
            "-$numStr"
        }
    }

    fun evaluate() {
        if (numbers.empty() || numStr.isEmpty() || operators.empty()) return

        val a = numbers.pop()
        val b = numStr.toDouble()

        val result = when (operators.pop()) {
            '+' -> a + b
            '-' -> a - b
            '*' -> a * b
            '/' -> a / b
            '%' -> a % b
            else -> Math.pow(a, b)
        }

        numbers.push(result)
        numStr = result.toString()
    }
}
