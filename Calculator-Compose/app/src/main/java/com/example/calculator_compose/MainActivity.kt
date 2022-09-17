package com.example.calculator_compose

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.example.calculator_compose.previews.DevicePreviews
import com.example.calculator_compose.previews.DisplayPreviews
import com.example.calculator_compose.previews.OrientationPreviews
import com.example.calculator_compose.ui.theme.CalcColors
import com.example.calculator_compose.ui.theme.CalculatorComposeTheme

class MainActivity : ComponentActivity() {
    private val calculatorViewModel by viewModels<CalculatorViewModel>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            CalculatorComposeTheme {
                Scaffold (
                    topBar = {
                        TopAppBar(
                            title = {
                                Text(text = "Calculator-Compose")
                            },
                            backgroundColor = MaterialTheme.colors.primary
                        )
                    },
                    content = { padding ->
                        // A surface container using the 'background' color from the theme
                        Surface(
                            color = MaterialTheme.colors.background,
                            modifier = Modifier
                                .padding(padding)
                        ) {
                            Calculator(calculatorViewModel)
                        }
                    }
                )
            }
        }
    }
}

@Composable
fun Calculator(calculatorViewModel: CalculatorViewModel) {
    Column(
        modifier = Modifier
            .padding(all = 16.dp)
            .fillMaxSize()
            .verticalScroll(rememberScrollState()),
        verticalArrangement = Arrangement.SpaceBetween
    ) {
        Text(
            text = calculatorViewModel.output,
            modifier = Modifier
                .fillMaxWidth()
                .testTag("output"), // makes it easier to find this component in tests
            color = MaterialTheme.colors.onBackground,
            textAlign = TextAlign.End,
            style = MaterialTheme.typography.h4
        )

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceEvenly
        ) {
            CalculatorButton(
                color = CalcColors.OTHER,
                text = "^",
                onClick = {
                    calculatorViewModel.addOperator('^')
                }
            )
            CalculatorButton(
                color = CalcColors.OTHER,
                text = "π"
            )
            CalculatorButton(
                color = CalcColors.CLEAR,
                text = "\u21A9",
                onClick = {
                    calculatorViewModel.backspace()
                }
            )
            CalculatorButton(
                color = CalcColors.CLEAR,
                text = "clear",
                onClick = {
                    calculatorViewModel.clearOutput()
                }
            )
        }

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceEvenly
        ) {
            CalculatorButton(
                color = CalcColors.OTHER,
                text = "("
            )
            CalculatorButton(
                color = CalcColors.OTHER,
                text = ")"
            )
            CalculatorButton(
                color = CalcColors.OPERATOR,
                text = "%",
                onClick = {
                    calculatorViewModel.addOperator('%')
                }
            )
            CalculatorButton(
                color = CalcColors.OPERATOR,
                text = "/",
                onClick = {
                    calculatorViewModel.addOperator('/')
                }
            )
        }

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceEvenly
        ) {
            CalculatorButton(
                color = CalcColors.NUMBER,
                text = "7",
                onClick = {
                    calculatorViewModel.addNumber('7')
                }
            )
            CalculatorButton(
                color = CalcColors.NUMBER,
                text = "8",
                onClick = {
                    calculatorViewModel.addNumber('8')
                }
            )
            CalculatorButton(
                color = CalcColors.NUMBER,
                text = "9",
                onClick = {
                    calculatorViewModel.addNumber('9')
                }
            )
            CalculatorButton(
                color = CalcColors.OPERATOR,
                text = "*",
                onClick = {
                    calculatorViewModel.addOperator('*')
                }
            )
        }

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceEvenly
        ) {
            CalculatorButton(
                color = CalcColors.NUMBER,
                text = "4",
                onClick = {
                    calculatorViewModel.addNumber('4')
                }
            )
            CalculatorButton(
                color = CalcColors.NUMBER,
                text = "5",
                onClick = {
                    calculatorViewModel.addNumber('5')
                }
            )
            CalculatorButton(
                color = CalcColors.NUMBER,
                text = "6",
                onClick = {
                    calculatorViewModel.addNumber('6')
                }
            )
            CalculatorButton(
                color = CalcColors.OPERATOR,
                text = "-",
                onClick = {
                    calculatorViewModel.addOperator('-')
                }
            )
        }

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceEvenly
        ) {
            CalculatorButton(
                color = CalcColors.NUMBER,
                text = "1",
                onClick = {
                    calculatorViewModel.addNumber('1')
                }
            )
            CalculatorButton(
                color = CalcColors.NUMBER,
                text = "2",
                onClick = {
                    calculatorViewModel.addNumber('2')
                }
            )
            CalculatorButton(
                color = CalcColors.NUMBER,
                text = "3",
                onClick = {
                    calculatorViewModel.addNumber('3')
                }
            )
            CalculatorButton(
                color = CalcColors.OPERATOR,
                text = "+",
                onClick = {
                    calculatorViewModel.addOperator('+')
                }
            )
        }

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceEvenly
        ) {
            CalculatorButton(
                color = CalcColors.NUMBER,
                text = "0",
                onClick = {
                    calculatorViewModel.addNumber('0')
                }
            )
            CalculatorButton(
                color = CalcColors.OTHER,
                text = ".",
                onClick = {
                    calculatorViewModel.addDecimal()
                }
            )
            CalculatorButton(
                color = CalcColors.OTHER,
                text = "(-)",
                onClick = {
                    calculatorViewModel.invertNumber()
                }
            )
            CalculatorButton(
                color = CalcColors.EVAL,
                text = "=",
                onClick = {
                    calculatorViewModel.evaluate()
                }
            )
        }
    }
}

@DisplayPreviews
@OrientationPreviews
@DevicePreviews
@Composable
fun DefaultPreview() {
    CalculatorComposeTheme {
        val calculatorViewModel = CalculatorViewModel()
        calculatorViewModel.output = "25 % 7"
        Calculator(calculatorViewModel)
    }
}
