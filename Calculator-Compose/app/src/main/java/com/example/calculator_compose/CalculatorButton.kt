package com.example.calculator_compose

import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import com.example.calculator_compose.previews.DisplayPreviews
import com.example.calculator_compose.ui.theme.CalcColors
import com.example.calculator_compose.ui.theme.CalculatorComposeTheme

@Composable
fun CalculatorButton(color: Color, text: String, onClick: (() -> Unit)? = null) {
    Button(
        onClick = onClick ?: {},
        modifier = Modifier
            .size(70.dp),
        shape = CircleShape,
        colors = ButtonDefaults.buttonColors(backgroundColor = color)
    ) {
        Text(
            text = text,
            color = Color.White
        )
    }
}

@DisplayPreviews
@Composable
fun PreviewCalculatorButton() {
    CalculatorComposeTheme {
        CalculatorButton(
            color = CalcColors.OPERATOR,
            text = "↑",
            onClick = {
                print("Knuth's up-arrow notation")
            }
        )
    }
}
