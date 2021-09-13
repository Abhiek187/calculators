package com.example.calculator_compose

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import kotlin.math.pow

class CalculatorViewModel: ViewModel() {
    var num1 = 0.0
    var op = '\u0000' // null character: \0
    var numStr = "0"
    var output by mutableStateOf("0") // by = delegated property

    fun clearOutput() {
        numStr = "0"
        num1 = 0.0
        op = '\u0000'
        output = "0"
    }

    fun addNumber(key: Char) {
        // Replace a 0 with the number
        when (numStr) {
            "0" -> numStr = key.toString()
            "-0" -> numStr = "-$key"
            else -> numStr += key
        }

        when (output) {
            "0" -> output = key.toString()
            "-0" -> output = "-$key"
            else -> output += key
        }
    }

    fun addDecimal() {
        // Don't add another decimal point if the number already contains one
        if (!numStr.contains(".")) {
            numStr += "."
            output += "."
        }
    }

    fun addOperator(key: Char) {
        // Simplify the left side of the expression before chaining additional operators
        evaluate()

        numStr.toDoubleOrNull()?.let { num ->
            num1 = num
            op = key
            numStr = ""
            output = "$num $key "
        }
    }

    fun invertNumber() {
        numStr = if (numStr.startsWith("-")) numStr.substring(1) else "-$numStr"

        output = if (op != '\u0000') {
            // Negate the right side of the expression
            "$num1 $op $numStr"
        } else {
            numStr
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

        if (output.isNotEmpty()) {
            output = if (output.last() == ' ') {
                // Remove the spaces in between the operator
                output.dropLast(3)
            } else {
                output.dropLast(1)
            }

            if (output.isEmpty()) {
                output = "0"
            }
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
            output = numStr
        }
    }
}
