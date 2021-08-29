package com.example.calculator

import org.junit.Assert.*
import org.junit.Before
import org.junit.Test

class MainActivityUnitTest {
    private lateinit var sut: MainActivity // system under test

    @Before
    fun init() {
        sut = MainActivity()
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
    fun addOperator_Valid() {
        sut.addNumber('2')
        sut.addNumber('1')
        sut.addOperator('%')

        assertEquals(sut.numbers.peek(), 21.0, Math.ulp(1.0))
        assertEquals(sut.operators.peek(), '%')
        assertTrue(sut.numStr.isEmpty())
    }

    @Test
    fun addOperator_Invalid() {
        sut.addOperator('+')

        assertTrue(sut.numbers.empty())
        assertTrue(sut.operators.empty())
        assertTrue(sut.numStr.isEmpty())
    }

    @Test
    fun invertNumber_Empty() {
        sut.invertNumber()

        assertEquals(sut.numStr, "-")
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
    fun evaluate_ValidAdd() {
        sut.addNumber('2')
        sut.addOperator('+')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(sut.numbers.peek(), 5.0, Math.ulp(1.0))
        assertTrue(sut.operators.empty())
        assertEquals(sut.numStr, "5.0")
    }

    @Test
    fun evaluate_ValidSubtract() {
        sut.addNumber('2')
        sut.addOperator('-')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(sut.numbers.peek(), -1.0, Math.ulp(1.0))
        assertTrue(sut.operators.empty())
        assertEquals(sut.numStr, "-1.0")
    }

    @Test
    fun evaluate_ValidMultiply() {
        sut.addNumber('2')
        sut.addOperator('*')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(sut.numbers.peek(), 6.0, Math.ulp(1.0))
        assertTrue(sut.operators.empty())
        assertEquals(sut.numStr, "6.0")
    }

    @Test
    fun evaluate_ValidDivide() {
        sut.addNumber('2')
        sut.addOperator('/')
        sut.addNumber('3')
        sut.evaluate()
        val answer = 2/3.0

        assertEquals(sut.numbers.peek(), answer, Math.ulp(1.0))
        assertTrue(sut.operators.empty())
        assertEquals(sut.numStr, answer.toString())
    }

    @Test
    fun evaluate_ValidMod() {
        sut.addNumber('2')
        sut.addOperator('%')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(sut.numbers.peek(), 2.0, Math.ulp(1.0))
        assertTrue(sut.operators.empty())
        assertEquals(sut.numStr, "2.0")
    }

    @Test
    fun evaluate_ValidExp() {
        sut.addNumber('2')
        sut.addOperator('^')
        sut.addNumber('3')
        sut.evaluate()

        assertEquals(sut.numbers.peek(), 8.0, Math.ulp(1.0))
        assertTrue(sut.operators.empty())
        assertEquals(sut.numStr, "8.0")
    }

    @Test
    fun evaluate_MissingFirstNum() {
        sut.evaluate()

        assertTrue(sut.numbers.empty())
        assertTrue(sut.operators.empty())
        assertTrue(sut.numStr.isEmpty())
    }

    @Test
    fun evaluate_MissingOperator() {
        sut.addNumber('2')
        sut.evaluate()

        assertTrue(sut.numbers.empty())
        assertTrue(sut.operators.empty())
        assertEquals(sut.numStr, "2")
    }

    @Test
    fun evaluate_MissingSecondNum() {
        sut.addNumber('2')
        sut.addOperator('^')
        sut.evaluate()

        assertEquals(sut.numbers.peek(), 2.0, Math.ulp(1.0))
        assertEquals(sut.operators.peek(), '^')
        assertTrue(sut.numStr.isEmpty())
    }

    @Test
    fun clearOutput_Empty() {
        sut.clearOutput()

        assertTrue(sut.numStr.isEmpty())
        assertTrue(sut.numbers.empty())
        assertTrue(sut.operators.empty())
    }

    @Test
    fun clearOutput_AfterFirstNum() {
        sut.addNumber('6')
        sut.clearOutput()

        assertTrue(sut.numStr.isEmpty())
        assertTrue(sut.numbers.empty())
        assertTrue(sut.operators.empty())
    }

    @Test
    fun clearOutput_AfterOperator() {
        sut.addNumber('6')
        sut.addOperator('/')
        sut.clearOutput()

        assertTrue(sut.numStr.isEmpty())
        assertTrue(sut.numbers.empty())
        assertTrue(sut.operators.empty())
    }

    @Test
    fun clearOutput_AfterSecondNum() {
        sut.addNumber('6')
        sut.addOperator('/')
        sut.addNumber('6')
        sut.clearOutput()

        assertTrue(sut.numStr.isEmpty())
        assertTrue(sut.numbers.empty())
        assertTrue(sut.operators.empty())
    }

    @Test
    fun clearOutput_AfterEvaluate() {
        sut.addNumber('6')
        sut.addOperator('/')
        sut.addNumber('6')
        sut.evaluate()
        sut.clearOutput()

        assertTrue(sut.numStr.isEmpty())
        assertTrue(sut.numbers.empty())
        assertTrue(sut.operators.empty())
    }
}
