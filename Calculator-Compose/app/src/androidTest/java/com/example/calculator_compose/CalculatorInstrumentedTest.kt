package com.example.calculator_compose

import androidx.compose.ui.test.*
import androidx.compose.ui.test.junit4.createComposeRule
import androidx.test.filters.SmallTest
import com.example.calculator_compose.ui.theme.CalculatorComposeTheme
import org.junit.Before
import org.junit.Rule
import org.junit.Test

@SmallTest
class CalculatorInstrumentedTest {
    @get:Rule
    val composeTestRule = createComposeRule()

    @Before
    fun init() {
        composeTestRule.setContent {
            CalculatorComposeTheme {
                Calculator(calculatorViewModel = CalculatorViewModel())
            }
        }

        // Print the Semantics tree
        composeTestRule
            .onRoot(useUnmergedTree = true)
            .printToLog(CalculatorInstrumentedTest::class.toString())
    }

    @Test
    fun simpleEquation() {
        // Calculate 2 + 3 and verify the output is correct at each step
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("")

        composeTestRule
            .onNodeWithText("2")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("2")

        composeTestRule
            .onNodeWithText("+")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("2 + ")

        composeTestRule
            .onNodeWithText("3")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("2 + 3")

        composeTestRule
            .onNodeWithText("=")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("5.0")
    }

    @Test
    fun complexEquation() {
        // Calculate -0.1 * 7 / 2 and verify the output is correct at each step
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("")

        composeTestRule
            .onNodeWithText("(-)")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-")

        composeTestRule
            .onNodeWithText("0")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-0")

        composeTestRule
            .onNodeWithText(".")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-0.")

        composeTestRule
            .onNodeWithText("1")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-0.1")

        composeTestRule
            .onNodeWithText("*")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-0.1 * ")

        composeTestRule
            .onNodeWithText("7")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-0.1 * 7")

        composeTestRule
            .onNodeWithText("=")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-0.7000000000000001")

        composeTestRule
            .onNodeWithText("/")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-0.7000000000000001 / ")

        composeTestRule
            .onNodeWithText("2")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-0.7000000000000001 / 2")

        composeTestRule
            .onNodeWithText("=")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-0.35000000000000003")
    }
}
