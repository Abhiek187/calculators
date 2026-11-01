import { render, screen, fireEvent } from "@testing-library/react-native";
import Calculator from "./Calculator";

describe("Calculator", () => {
  beforeEach(async () => {
    await render(<Calculator />);
  });

  afterEach(() => {
    // Clear the output after each test
    press("clear");
  });

  const press = async (buttonText: string) => {
    // Press the button
    const button = screen.getByText(buttonText);
    await fireEvent.press(button);
  };

  const expectOutput = (expectedOutput: string) => {
    // Check that the output displays the correct string
    expect(screen.getByTestId("output")).toHaveTextContent(
      expectedOutput.trim()
    );
  };

  it("solves a simple equation", async () => {
    // 2 + 3 = 5
    expectOutput("0");

    await press("2");
    expectOutput("2");

    await press("+");
    expectOutput("2 + ");

    await press("3");
    expectOutput("2 + 3");

    await press("=");
    expectOutput("5");
  });

  it("solves a complex equation", async () => {
    // -0.1 * 7 / 2 = -0.35
    expectOutput("0");

    await press("(-)");
    expectOutput("-0");

    await press("0");
    expectOutput("-0");

    await press(".");
    expectOutput("-0.");

    await press("1");
    expectOutput("-0.1");

    await press("*");
    expectOutput("-0.1 * ");

    await press("7");
    expectOutput("-0.1 * 7");

    await press("/");
    expectOutput("-0.7000000000000001 / ");

    await press("2");
    expectOutput("-0.7000000000000001 / 2");

    await press("=");
    expectOutput("-0.35000000000000003");
  });

  it("solves a weird equation", async () => {
    // 0 ^ 0 = 1, 1 / -0 = -infinity, -infinity % 0 = NaN
    expectOutput("0");

    await press("^");
    expectOutput("0 ^ ");

    await press("0");
    expectOutput("0 ^ 0");

    await press("/");
    expectOutput("1 / ");

    await press("(-)");
    expectOutput("1 / -");

    await press("0");
    expectOutput("1 / -0");

    await press("%");
    expectOutput("-Infinity % ");

    await press("0");
    expectOutput("-Infinity % 0");

    await press("(-)");
    expectOutput("-Infinity % -0");

    await press("(-)");
    expectOutput("-Infinity % 0");

    await press("=");
    expectOutput("NaN");
  });

  it("solves no equation", async () => {
    // -1 ^ 0.5
    expectOutput("0");

    await press("1");
    expectOutput("1");

    await press("(-)");
    expectOutput("-1");

    await press("^");
    expectOutput("-1 ^ ");

    await press("0");
    expectOutput("-1 ^ 0");

    await press(".");
    expectOutput("-1 ^ 0.");

    await press("5");
    expectOutput("-1 ^ 0.5");

    await press("↩︎");
    expectOutput("-1 ^ 0.");

    await press("↩︎");
    expectOutput("-1 ^ 0");

    await press("↩︎");
    expectOutput("-1 ^ ");

    await press("↩︎");
    expectOutput("-1");

    await press("↩︎");
    expectOutput("-");

    await press("↩︎");
    expectOutput("0");
  });
});
