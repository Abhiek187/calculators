package com.example.calculator_compose

import org.junit.Assert.*
import org.junit.Before
import org.junit.Test

// Generated using Alt/Option+Enter on the class name
class CalculatorViewModelTest {
    private lateinit var sut: CalculatorViewModel // system under test

    @Before
    fun init() {
        sut = CalculatorViewModel()
    }

    @Test
    fun addNumber_Integer() {
        sut.addNumber('7')
        sut.addNumber('2')
        sut.addNumber('9')

        assertEquals(sut.numStr, "729")
    }

    @Test
    fun addNumber_Decimal() {
        sut.addNumber('3')
        sut.addNumber('.')
        sut.addNumber('1')
        sut.addNumber('4')

        assertEquals(sut.numStr, "3.14")
    }

    @Test
    fun addNumber_MultipleDecimals() {
        sut.addNumber('8')
        sut.addDecimal()
        sut.addDecimal()
        sut.addNumber('0')
        sut.addDecimal()

        assertEquals(sut.numStr, "8.0")
    }

    @Test
    fun addOperator_Valid() {
        sut.addNumber('2')
        sut.addNumber('1')
        sut.addOperator('%')

        assertEquals(sut.num1, 21.0, Math.ulp(1.0))
        assertEquals(sut.op, '%')
        assertTrue(sut.numStr.isEmpty())
    }

    @Test
    fun addOperator_Empty() {
        sut.addOperator('+')

        assertEquals(sut.num1, 0.0, Math.ulp(1.0))
        assertEquals(sut.op, '+')
        assertTrue(sut.numStr.isEmpty())
    }

    @Test
    fun invertNumber_Empty() {
        sut.invertNumber()

        assertEquals(sut.numStr, "-0")
    }

    @Test
    fun invertNumber_Once() {
        sut.addNumber('5')
        sut.addNumber('4')
        sut.invertNumber()

        assertEquals(sut.numStr, "-54")
    }

    @Test
    fun invertNumber_Twice() {
        sut.addNumber('5')
        sut.invertNumber()
        sut.addNumber('4')
        sut.invertNumber()

        assertEquals(sut.numStr, "54")
    }

    @Test
    fun backspace_Empty() {
        sut.backspace()

        assertEquals(sut.num1, 0.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar()) // == \u0000 = \0
        assertEquals(sut.numStr, "0")
    }

    @Test
    fun backspace_SingleNum() {
        sut.addNumber('9')
        sut.backspace()

        assertEquals(sut.num1, 0.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "0")
    }

    @Test
    fun backspace_DoubleNum() {
        sut.addNumber('7')
        sut.addNumber('8')
        sut.backspace()

        assertEquals(sut.num1, 0.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "7")
    }

    @Test
    fun backspace_Operator() {
        sut.addNumber('0')
        sut.addOperator('/')
        sut.backspace()

        assertEquals(sut.num1, 0.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "0.0")
    }

    @Test
    fun backspace_SecondNum() {
        sut.addNumber('2')
        sut.addOperator('^')
        sut.addNumber('8')
        sut.backspace()

        assertEquals(sut.num1, 2.0, Math.ulp(1.0))
        assertEquals(sut.op, '^')
        assertEquals(sut.numStr, "0")
    }

    @Test
    fun evaluate_ValidAdd() {
        sut.addNumber('2')
        sut.addOperator('+')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(sut.num1, 5.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "5.0")
    }

    @Test
    fun evaluate_ValidSubtract() {
        sut.addNumber('2')
        sut.addOperator('-')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(sut.num1, -1.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "-1.0")
    }

    @Test
    fun evaluate_ValidMultiply() {
        sut.addNumber('2')
        sut.addOperator('*')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(sut.num1, 6.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "6.0")
    }

    @Test
    fun evaluate_ValidDivide() {
        sut.addNumber('2')
        sut.addOperator('/')
        sut.addNumber('3')
        sut.evaluate()
        val answer = 2/3.0

        assertEquals(sut.num1, answer, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, answer.toString())
    }

    @Test
    fun evaluate_ValidMod() {
        sut.addNumber('2')
        sut.addOperator('%')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(sut.num1, 2.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "2.0")
    }

    @Test
    fun evaluate_ValidExp() {
        sut.addNumber('2')
        sut.addOperator('^')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(sut.num1, 8.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "8.0")
    }

    @Test
    fun evaluate_MissingFirstNum() {
        sut.evaluate()

        assertEquals(sut.num1, 0.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "0.0")
    }

    @Test
    fun evaluate_MissingOperator() {
        sut.addNumber('2')
        sut.evaluate()

        assertEquals(sut.num1, 2.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "2.0")
    }

    @Test
    fun evaluate_MissingSecondNum() {
        sut.addNumber('2')
        sut.addOperator('^')
        sut.evaluate()

        assertEquals(sut.num1, 2.0, Math.ulp(1.0))
        assertEquals(sut.op, '^')
        assertTrue(sut.numStr.isEmpty())
    }

    @Test
    fun clearOutput_Empty() {
        sut.clearOutput()

        assertEquals(sut.num1, 0.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "0")
    }

    @Test
    fun clearOutput_AfterFirstNum() {
        sut.addNumber('6')
        sut.clearOutput()

        assertEquals(sut.num1, 0.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "0")
    }

    @Test
    fun clearOutput_AfterOperator() {
        sut.addNumber('6')
        sut.addOperator('/')
        sut.clearOutput()

        assertEquals(sut.num1, 0.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "0")
    }

    @Test
    fun clearOutput_AfterSecondNum() {
        sut.addNumber('6')
        sut.addOperator('/')
        sut.addNumber('6')
        sut.clearOutput()

        assertEquals(sut.num1, 0.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "0")
    }

    @Test
    fun clearOutput_AfterEvaluate() {
        sut.addNumber('6')
        sut.addOperator('/')
        sut.addNumber('6')
        sut.evaluate()
        sut.clearOutput()

        assertEquals(sut.num1, 0.0, Math.ulp(1.0))
        assertEquals(sut.op, 0.toChar())
        assertEquals(sut.numStr, "0")
    }
}
