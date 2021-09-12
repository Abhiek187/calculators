package com.example.calculator

import androidx.test.core.app.ActivityScenario
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions.click
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.espresso.matcher.ViewMatchers.withText
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.filters.SmallTest
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
@SmallTest
class MainActivityInstrumentedTest {
    private lateinit var activityScenario: ActivityScenario<MainActivity>

    @Before
    fun init() {
        activityScenario = ActivityScenario.launch(MainActivity::class.java)
    }

    @After
    fun reset() {
        activityScenario.close()
    }

    @Test
    fun simpleEquation() {
        // 2 + 3 = 5
        onView(withId(R.id.textViewOutput)).check(matches(withText("0")))
        onView(withId(R.id.button2)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("2")))
        onView(withId(R.id.buttonPlus)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("2.0 + ")))
        onView(withId(R.id.button3)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("2.0 + 3")))
        onView(withId(R.id.buttonEquals)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("5.0")))
    }

    @Test
    fun complexEquation() {
        // -0.1 * 7 / 2 = -0.35
        onView(withId(R.id.textViewOutput)).check(matches(withText("0")))
        onView(withId(R.id.buttonNegative)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-0")))
        onView(withId(R.id.button0)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-0")))
        onView(withId(R.id.buttonDot)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-0.")))
        onView(withId(R.id.button1)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-0.1")))
        onView(withId(R.id.buttonMultiply)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-0.1 * ")))
        onView(withId(R.id.button7)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-0.1 * 7")))

        onView(withId(R.id.buttonDivide)).perform(click())
        onView(withId(R.id.textViewOutput))
            .check(matches(withText("-0.7000000000000001 / ")))
        onView(withId(R.id.button2)).perform(click())
        onView(withId(R.id.textViewOutput))
            .check(matches(withText("-0.7000000000000001 / 2")))
        onView(withId(R.id.buttonEquals)).perform(click())
        onView(withId(R.id.textViewOutput))
            .check(matches(withText("-0.35000000000000003")))
    }

    @Test
    fun weirdEquation() {
        // 0 ^ 0 = 1, 1 / -0 = -infinity, -infinity % 0 = NaN
        onView(withId(R.id.textViewOutput)).check(matches(withText("0")))
        onView(withId(R.id.buttonExponent)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("0.0 ^ ")))
        onView(withId(R.id.button0)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("0.0 ^ 0")))

        onView(withId(R.id.buttonDivide)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("1.0 / ")))
        onView(withId(R.id.buttonNegative)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("1.0 / -")))
        onView(withId(R.id.button0)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("1.0 / -0")))

        onView(withId(R.id.buttonMod)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-Infinity % ")))
        onView(withId(R.id.button0)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-Infinity % 0")))
        onView(withId(R.id.buttonNegative)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-Infinity % -0")))
        onView(withId(R.id.buttonNegative)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-Infinity % 0")))
        onView(withId(R.id.buttonEquals)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("NaN")))
    }

    @Test
    fun noEquation() {
        // -1 ^ 0.5
        onView(withId(R.id.textViewOutput)).check(matches(withText("0")))
        onView(withId(R.id.button1)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("1")))
        onView(withId(R.id.buttonNegative)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-1")))
        onView(withId(R.id.buttonExponent)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-1.0 ^ ")))
        onView(withId(R.id.button0)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-1.0 ^ 0")))
        onView(withId(R.id.buttonDot)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-1.0 ^ 0.")))
        onView(withId(R.id.button5)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-1.0 ^ 0.5")))

        onView(withId(R.id.buttonBackspace)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-1.0 ^ 0.")))
        onView(withId(R.id.buttonBackspace)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-1.0 ^ 0")))
        onView(withId(R.id.buttonBackspace)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-1.0 ^ ")))
        onView(withId(R.id.buttonBackspace)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-1.0")))
        onView(withId(R.id.buttonBackspace)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-1.")))
        onView(withId(R.id.buttonBackspace)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-1")))
        onView(withId(R.id.buttonBackspace)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("-")))
        onView(withId(R.id.buttonBackspace)).perform(click())
        onView(withId(R.id.textViewOutput)).check(matches(withText("0")))
    }
}
