package com.example.calculator

import android.annotation.SuppressLint
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.example.calculator.databinding.ActivityMainBinding
import kotlin.math.pow


class MainActivity : AppCompatActivity() {
    var num1 = 0.0
    var op = '\u0000' // null character: \0
    var numStr = "0" // string to build up a number

    private lateinit var binding: ActivityMainBinding
    private lateinit var textViewOutput: TextView

    @SuppressLint("SetTextI18n")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        textViewOutput = binding.textViewOutput

        with (binding) {
            // Implement all the button click listeners
            buttonExponent.setOnClickListener {
                // a ^ b
                onTapButtonOp('^')
            }

            buttonPi.setOnClickListener {
                // pi
                it.isEnabled = false
            }

            buttonBackspace.setOnClickListener {
                // Remove part of the output
                backspace()

                if (textViewOutput.text.isNotEmpty()) {
                    if (textViewOutput.text.last() == ' ') {
                        // Remove the spaces in between the operator
                        textViewOutput.text = textViewOutput.text.dropLast(3)
                    } else {
                        textViewOutput.text = textViewOutput.text.dropLast(1)
                    }

                    if (textViewOutput.text.isEmpty()) {
                        textViewOutput.text = "0"
                    }
                }
            }

            buttonClear.setOnClickListener {
                // Clear the output
                clearOutput()
                textViewOutput.text = "0"
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
                onTapButtonOp('%')
            }

            buttonDivide.setOnClickListener {
                // a / b
                onTapButtonOp('/')
            }

            button7.setOnClickListener {
                // 7
                onTapButtonNum('7')
            }

            button8.setOnClickListener {
                // 8
               onTapButtonNum('8')
            }

            button9.setOnClickListener {
                // 9
                onTapButtonNum('9')
            }

            buttonMultiply.setOnClickListener {
                // *
                onTapButtonOp('*')
            }

            button4.setOnClickListener {
                // 4
                onTapButtonNum('4')
            }

            button5.setOnClickListener {
                // 5
                onTapButtonNum('5')
            }

            button6.setOnClickListener {
                // 6
                onTapButtonNum('6')
            }

            buttonMinus.setOnClickListener {
                // a - b
                onTapButtonOp('-')
            }

            button1.setOnClickListener {
                // 1
                onTapButtonNum('1')
            }

            button2.setOnClickListener {
                // 2
                onTapButtonNum('2')
            }

            button3.setOnClickListener {
                // 3
                onTapButtonNum('3')
            }

            buttonPlus.setOnClickListener {
                // a + b
                onTapButtonOp('+')
            }

            button0.setOnClickListener {
                // 0
                onTapButtonNum('0')
            }

            buttonDot.setOnClickListener {
                // Add a decimal point to the number
                if (!numStr.contains(".")) {
                    addDecimal()
                    textViewOutput.append(".")
                }
            }

            buttonNegative.setOnClickListener {
                // Invert the sign of the number
                invertNumber()

                if (op != '\u0000') {
                    // Negate the right side of the expression
                    textViewOutput.text = "$num1 $op $numStr"
                } else {
                    textViewOutput.text = numStr
                }
            }

            buttonEquals.setOnClickListener {
                // Evaluate the expression
                evaluate()

                if (numStr.isNotEmpty()) {
                    textViewOutput.text = numStr
                }
            }
        }
    }

    private fun onTapButtonOp(key: Char) {
        // Simplify the left side of the expression before chaining additional operators
        evaluate()

        numStr.toDoubleOrNull()?.let {
            textViewOutput.text = numStr
            addOperator(key)
            textViewOutput.append(" $key ")
        }
    }

    @SuppressLint("SetTextI18n")
    private fun onTapButtonNum(key: Char) {
        addNumber(key)

        when (textViewOutput.text) {
            "0" -> textViewOutput.text = key.toString()
            "-0" -> textViewOutput.text = "-$key"
            else -> textViewOutput.append(key.toString())
        }
    }

    fun clearOutput() {
        numStr = "0"
        num1 = 0.0
        op = '\u0000'
    }

    fun addNumber(key: Char) {
        // Replace a 0 with the number
        when (numStr) {
            "0" -> numStr = key.toString()
            "-0" -> numStr = "-$key"
            else -> numStr += key
        }
    }

    fun addDecimal() {
        // Don't add another decimal point if the number already contains one
        if (!numStr.contains(".")) {
            numStr += "."
        }
    }

    fun addOperator(key: Char) {
        // Simplify the left side of the expression before chaining additional operators
        evaluate()

        numStr.toDoubleOrNull()?.let { num ->
            num1 = num
            op = key
            numStr = ""
        }
    }

    fun invertNumber() {
        numStr = if (numStr.startsWith("-")) {
            numStr.substring(1)
        } else {
            "-$numStr"
        }
    }

    fun backspace() {
        if (numStr.isNotEmpty()) {
            numStr = numStr.dropLast(1)

            if (numStr.isEmpty()) {
                numStr = "0" // show 0 when there's no text
            }
        } else if (op != '\u0000') {
            // Undo addOperator after deleting an operator
            numStr = num1.toString()
            num1 = 0.0
            op = '\u0000'
        }
    }

    fun evaluate() {
        numStr.toDoubleOrNull()?.let { num2 ->
            val result = when (op) {
                '+' -> num1 + num2
                '-' -> num1 - num2
                '*' -> num1 * num2
                '/' -> num1 / num2
                '%' -> num1 % num2
                '^' -> num1.pow(num2)
                else -> num2
            }

            num1 = result
            numStr = result.toString()
            op = '\u0000'
        }
    }
}
