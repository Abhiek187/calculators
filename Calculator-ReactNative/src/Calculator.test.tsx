import { render, screen, fireEvent } from "@testing-library/react-native";
import React from "react";
import Calculator from "./Calculator";

describe("Calculator", () => {
  beforeEach(() => {
    render(<Calculator />);
  });

  afterEach(() => {
    // Clear the output after each test
    press("clear");
  });

  const press = (buttonText: string) => {
    // Press the button
    const button = screen.getByText(buttonText);
    fireEvent.press(button);
  };

  const expectOutput = (expectedOutput: string) => {
    // Check that the output displays the correct string
    expect(screen.getByTestId("output")).toHaveTextContent(
      expectedOutput.trim()
    );
  };

  it("solves a simple equation", () => {
    // 2 + 3 = 5
    expectOutput("0");

    press("2");
    expectOutput("2");

    press("+");
    expectOutput("2 + ");

    press("3");
    expectOutput("2 + 3");

    press("=");
    expectOutput("5");
  });

  it("solves a complex equation", () => {
    // -0.1 * 7 / 2 = -0.35
    expectOutput("0");

    press("(-)");
    expectOutput("-0");

    press("0");
    expectOutput("-0");

    press(".");
    expectOutput("-0.");

    press("1");
    expectOutput("-0.1");

    press("*");
    expectOutput("-0.1 * ");

    press("7");
    expectOutput("-0.1 * 7");

    press("/");
    expectOutput("-0.7000000000000001 / ");

    press("2");
    expectOutput("-0.7000000000000001 / 2");

    press("=");
    expectOutput("-0.35000000000000003");
  });

  it("solves a weird equation", () => {
    // 0 ^ 0 = 1, 1 / -0 = -infinity, -infinity % 0 = NaN
    expectOutput("0");

    press("^");
    expectOutput("0 ^ ");

    press("0");
    expectOutput("0 ^ 0");

    press("/");
    expectOutput("1 / ");

    press("(-)");
    expectOutput("1 / -");

    press("0");
    expectOutput("1 / -0");

    press("%");
    expectOutput("-Infinity % ");

    press("0");
    expectOutput("-Infinity % 0");

    press("(-)");
    expectOutput("-Infinity % -0");

    press("(-)");
    expectOutput("-Infinity % 0");

    press("=");
    expectOutput("NaN");
  });

  it("solves no equation", () => {
    // -1 ^ 0.5
    expectOutput("0");

    press("1");
    expectOutput("1");

    press("(-)");
    expectOutput("-1");

    press("^");
    expectOutput("-1 ^ ");

    press("0");
    expectOutput("-1 ^ 0");

    press(".");
    expectOutput("-1 ^ 0.");

    press("5");
    expectOutput("-1 ^ 0.5");

    press("↩︎");
    expectOutput("-1 ^ 0.");

    press("↩︎");
    expectOutput("-1 ^ 0");

    press("↩︎");
    expectOutput("-1 ^ ");

    press("↩︎");
    expectOutput("-1");

    press("↩︎");
    expectOutput("-");

    press("↩︎");
    expectOutput("0");
  });
});
