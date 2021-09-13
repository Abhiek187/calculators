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
        // 2 + 3 = 5
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("0")

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
            .assertTextEquals("2.0 + ")

        composeTestRule
            .onNodeWithText("3")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("2.0 + 3")

        composeTestRule
            .onNodeWithText("=")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("5.0")
    }

    @Test
    fun complexEquation() {
        // -0.1 * 7 / 2 = -0.35
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("0")

        composeTestRule
            .onNodeWithText("(-)")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-0")

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

    @Test
    fun weirdEquation() {
        // 0 ^ 0 = 1, 1 / -0 = -infinity, -infinity % 0 = NaN
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("0")

        composeTestRule
            .onNodeWithText("^")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("0.0 ^ ")

        composeTestRule
            .onNodeWithText("0")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("0.0 ^ 0")

        composeTestRule
            .onNodeWithText("/")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("1.0 / ")

        composeTestRule
            .onNodeWithText("(-)")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("1.0 / -")

        composeTestRule
            .onNodeWithText("0")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("1.0 / -0")

        composeTestRule
            .onNodeWithText("%")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-Infinity % ")

        composeTestRule
            .onNodeWithText("0")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-Infinity % 0")

        composeTestRule
            .onNodeWithText("(-)")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-Infinity % -0")

        composeTestRule
            .onNodeWithText("(-)")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-Infinity % 0")

        composeTestRule
            .onNodeWithText("=")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("NaN")
    }

    @Test
    fun noEquation() {
        // -1 ^ 0.5
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("0")

        composeTestRule
            .onNodeWithText("1")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("1")

        composeTestRule
            .onNodeWithText("(-)")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-1")

        composeTestRule
            .onNodeWithText("^")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-1.0 ^ ")

        composeTestRule
            .onNodeWithText("0")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-1.0 ^ 0")

        composeTestRule
            .onNodeWithText(".")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-1.0 ^ 0.")

        composeTestRule
            .onNodeWithText("5")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-1.0 ^ 0.5")

        composeTestRule
            .onNodeWithText("\u21A9")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-1.0 ^ 0.")

        composeTestRule
            .onNodeWithText("\u21A9")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-1.0 ^ 0")

        composeTestRule
            .onNodeWithText("\u21A9")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-1.0 ^ ")

        composeTestRule
            .onNodeWithText("\u21A9")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-1.0")

        composeTestRule
            .onNodeWithText("\u21A9")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-1.")

        composeTestRule
            .onNodeWithText("\u21A9")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-1")

        composeTestRule
            .onNodeWithText("\u21A9")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("-")

        composeTestRule
            .onNodeWithText("\u21A9")
            .performClick()
        composeTestRule
            .onNode(hasTestTag("output"))
            .assertTextEquals("0")
    }
}
