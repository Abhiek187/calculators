package com.example.calculator_view

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import org.junit.Assert.*
import org.junit.Before
import org.junit.Rule
import org.junit.Test

class CalculatorViewModelTest {
    private lateinit var sut: CalculatorViewModel // system under test

    // Fixes error: Method getMainLooper in android.os.Looper not mocked
    @get:Rule
    val taskExecutorRule = InstantTaskExecutorRule()

    @Before
    fun init() {
        sut = CalculatorViewModel()
    }

    @Test
    fun addNumber_Integer() {
        sut.addNumber('7')
        sut.addNumber('2')
        sut.addNumber('9')

        assertEquals("729", sut.numStr)
    }

    @Test
    fun addNumber_Decimal() {
        sut.addNumber('3')
        sut.addDecimal()
        sut.addNumber('1')
        sut.addNumber('4')

        assertEquals("3.14", sut.numStr)
    }

    @Test
    fun addNumber_MultipleDecimals() {
        sut.addNumber('8')
        sut.addDecimal()
        sut.addDecimal()
        sut.addNumber('0')
        sut.addDecimal()

        assertEquals("8.0", sut.numStr)
    }

    @Test
    fun addOperator_Valid() {
        sut.addNumber('2')
        sut.addNumber('1')
        sut.addOperator('%')

        assertEquals(21.0, sut.num1, Math.ulp(1.0))
        assertEquals('%', sut.op)
        assertTrue(sut.numStr.isEmpty())
    }

    @Test
    fun addOperator_Empty() {
        sut.addOperator('+')

        assertEquals(0.0, sut.num1, Math.ulp(1.0))
        assertEquals('+', sut.op)
        assertTrue(sut.numStr.isEmpty())
    }

    @Test
    fun invertNumber_Empty() {
        sut.invertNumber()

        assertEquals("-0", sut.numStr)
    }

    @Test
    fun invertNumber_Once() {
        sut.addNumber('5')
        sut.addNumber('4')
        sut.invertNumber()

        assertEquals("-54", sut.numStr)
    }

    @Test
    fun invertNumber_Twice() {
        sut.addNumber('5')
        sut.invertNumber()
        sut.addNumber('4')
        sut.invertNumber()

        assertEquals("54", sut.numStr)
    }

    @Test
    fun backspace_Empty() {
        sut.backspace()

        assertEquals(0.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op) // == \u0000 = \0
        assertEquals("0", sut.numStr)
    }

    @Test
    fun backspace_SingleNum() {
        sut.addNumber('9')
        sut.backspace()

        assertEquals(0.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
        assertEquals("0", sut.numStr)
    }

    @Test
    fun backspace_DoubleNum() {
        sut.addNumber('7')
        sut.addNumber('8')
        sut.backspace()

        assertEquals(0.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
        assertEquals("7", sut.numStr)
    }

    @Test
    fun backspace_Operator() {
        sut.addNumber('0')
        sut.addOperator('/')
        sut.backspace()

        assertEquals(0.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
        assertEquals("0.0", sut.numStr)
    }

    @Test
    fun backspace_SecondNum() {
        sut.addNumber('2')
        sut.addOperator('^')
        sut.addNumber('8')
        sut.backspace()

        assertEquals(2.0, sut.num1, Math.ulp(1.0))
        assertEquals('^', sut.op)
        assertEquals("0", sut.numStr)
    }

    @Test
    fun evaluate_ValidAdd() {
        sut.addNumber('2')
        sut.addOperator('+')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(5.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
        assertEquals("5.0", sut.numStr)
    }

    @Test
    fun evaluate_ValidSubtract() {
        sut.addNumber('2')
        sut.addOperator('-')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(-1.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
        assertEquals("-1.0", sut.numStr)
    }

    @Test
    fun evaluate_ValidMultiply() {
        sut.addNumber('2')
        sut.addOperator('*')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(6.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
        assertEquals("6.0", sut.numStr)
    }

    @Test
    fun evaluate_ValidDivide() {
        sut.addNumber('2')
        sut.addOperator('/')
        sut.addNumber('3')
        sut.evaluate()
        val answer = 2/3.0

        assertEquals(2/3.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
        assertEquals(answer.toString(), sut.numStr)
    }

    @Test
    fun evaluate_ValidMod() {
        sut.addNumber('2')
        sut.addOperator('%')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(2.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
        assertEquals("2.0", sut.numStr)
    }

    @Test
    fun evaluate_ValidExp() {
        sut.addNumber('2')
        sut.addOperator('^')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(8.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
        assertEquals("8.0", sut.numStr)
    }

    @Test
    fun evaluate_MissingFirstNum() {
        sut.evaluate()

        assertEquals(0.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
        assertEquals("0.0", sut.numStr)
    }

    @Test
    fun evaluate_MissingOperator() {
        sut.addNumber('2')
        sut.evaluate()

        assertEquals(2.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
        assertEquals("2.0", sut.numStr)
    }

    @Test
    fun evaluate_MissingSecondNum() {
        sut.addNumber('2')
        sut.addOperator('^')
        sut.evaluate()

        assertEquals(2.0, sut.num1, Math.ulp(1.0))
        assertEquals('^', sut.op)
        assertTrue(sut.numStr.isEmpty())
    }

    @Test
    fun clearOutput_Empty() {
        sut.clearOutput()

        assertEquals("0", sut.numStr)
        assertEquals(0.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
    }

    @Test
    fun clearOutput_AfterFirstNum() {
        sut.addNumber('6')
        sut.clearOutput()

        assertEquals("0", sut.numStr)
        assertEquals(0.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
    }

    @Test
    fun clearOutput_AfterOperator() {
        sut.addNumber('6')
        sut.addOperator('/')
        sut.clearOutput()

        assertEquals("0", sut.numStr)
        assertEquals(0.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
    }

    @Test
    fun clearOutput_AfterSecondNum() {
        sut.addNumber('6')
        sut.addOperator('/')
        sut.addNumber('6')
        sut.clearOutput()

        assertEquals("0", sut.numStr)
        assertEquals(0.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
    }

    @Test
    fun clearOutput_AfterEvaluate() {
        sut.addNumber('6')
        sut.addOperator('/')
        sut.addNumber('6')
        sut.evaluate()
        sut.clearOutput()

        assertEquals("0", sut.numStr)
        assertEquals(0.0, sut.num1, Math.ulp(1.0))
        assertEquals(0.toChar(), sut.op)
    }
}
