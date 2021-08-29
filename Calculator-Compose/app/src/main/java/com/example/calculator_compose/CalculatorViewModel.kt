package com.example.calculator_compose

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import kotlin.math.pow

class CalculatorViewModel: ViewModel() {
    var num1 = 0.0
    var op = '\u0000' // null character: \0
    var numStr = ""
    var output by mutableStateOf("") // by = delegated property

    fun clearOutput() {
        numStr = ""
        num1 = 0.0
        op = '\u0000'
        output = ""
    }

    fun addNumber(key: Char) {
        numStr += key
        output += key
    }

    fun addOperator(key: Char) {
        numStr.toDoubleOrNull()?.let { num ->
            num1 = num
            op = key
            numStr = ""
            output += " $key "
        }
    }

    fun invertNumber() {
        numStr = if (numStr.startsWith("-")) numStr.substring(1) else "-$numStr"
        output = numStr
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
