package com.example.calculator_view

import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import com.example.calculator_view.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {
    private val calculatorViewModel by viewModels<CalculatorViewModel>() // by = delegated property

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        val textViewOutput = binding.textViewOutput

        calculatorViewModel.output.observe(this) { newOutput ->
            // Update textViewOutput every time the output in the ViewModel changes
            textViewOutput.text = newOutput
        }

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
                calculatorViewModel.backspace()
            }

            buttonClear.setOnClickListener {
                // Clear the output
                calculatorViewModel.clearOutput()
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
                calculatorViewModel.addDecimal()
            }

            buttonNegative.setOnClickListener {
                // Invert the sign of the number
                calculatorViewModel.invertNumber()
            }

            buttonEquals.setOnClickListener {
                // Evaluate the expression
                calculatorViewModel.evaluate()
            }
        }
    }

    private fun onTapButtonOp(key: Char) {
        // Simplify the left side of the expression before chaining additional operators
        calculatorViewModel.addOperator(key)
    }

    private fun onTapButtonNum(key: Char) {
        calculatorViewModel.addNumber(key)
    }
}
