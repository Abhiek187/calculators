import * as sut from "./calc-methods";

beforeEach(() => {
  // Reset all the internal variables
  sut.resetVariables();
});

describe("AddNumber", () => {
  it("adds 2 integers", () => {
    sut.addNumber("7");
    sut.addNumber("2");
    sut.addNumber("9");

    expect(sut.numStr).toBe("729");
  });

  it("adds 2 decimals", () => {
    sut.addNumber("3");
    sut.addNumber(".");
    sut.addNumber("1");
    sut.addNumber("4");

    expect(sut.numStr).toBe("3.14");
  });
});

describe("AddOperator", () => {
  it("works with valid numbers", () => {
    sut.addNumber("2");
    sut.addNumber("1");
    sut.addOperator("%");

    expect(sut.num1).toBeCloseTo(21);
    expect(sut.op).toBe("%");
    expect(sut.numStr).toBe("");
  });

  it("works with invalid numbers", () => {
    sut.addOperator("+");

    expect(sut.num1).toBeCloseTo(0);
    expect(sut.op).toBe("");
    expect(sut.numStr).toBe("");
  });
});

describe("InvertNumber", () => {
  it("inverts nothing", () => {
    sut.invertNumber();

    expect(sut.numStr).toBe("-");
  });

  it("inverts once", () => {
    sut.addNumber("5");
    sut.addNumber("4");
    sut.invertNumber();

    expect(sut.numStr).toBe("-54");
  });

  it("inverts twice", () => {
    sut.addNumber("5");
    sut.invertNumber();
    sut.addNumber("4");
    sut.invertNumber();

    expect(sut.numStr).toBe("54");
  });
});

describe("Evaluate", () => {
  it("solves valid addition", () => {
    sut.addNumber("2");
    sut.addOperator("+");
    sut.addNumber("3");
    sut.evaluate();

    expect(sut.num1).toBeCloseTo(5);
    expect(sut.op).toBe("");
    expect(sut.numStr).toBe("5");
  });

  it("solves valid subtraction", () => {
    sut.addNumber("2");
    sut.addOperator("-");
    sut.addNumber("3");
    sut.evaluate();

    expect(sut.num1).toBeCloseTo(-1);
    expect(sut.op).toBe("");
    expect(sut.numStr).toBe("-1");
  });

  it("solves valid multiplication", () => {
    sut.addNumber("2");
    sut.addOperator("*");
    sut.addNumber("3");
    sut.evaluate();

    expect(sut.num1).toBeCloseTo(6);
    expect(sut.op).toBe("");
    expect(sut.numStr).toBe("6");
  });

  it("solves valid division", () => {
    sut.addNumber("2");
    sut.addOperator("/");
    sut.addNumber("3");
    sut.evaluate();
    const answer: number = 2 / 3;

    expect(sut.num1).toBeCloseTo(answer);
    expect(sut.op).toBe("");
    expect(sut.numStr).toBe(answer.toString());
  });

  it("solves valid modulo", () => {
    sut.addNumber("2");
    sut.addOperator("%");
    sut.addNumber("3");
    sut.evaluate();

    expect(sut.num1).toBeCloseTo(2);
    expect(sut.op).toBe("");
    expect(sut.numStr).toBe("2");
  });

  it("solves valid exponentation", () => {
    sut.addNumber("2");
    sut.addOperator("^");
    sut.addNumber("3");
    sut.evaluate();

    expect(sut.num1).toBeCloseTo(8);
    expect(sut.op).toBe("");
    expect(sut.numStr).toBe("8");
  });

  it("evaluates if missing the first number", () => {
    sut.evaluate();

    expect(sut.num1).toBeCloseTo(0);
    expect(sut.op).toBe("");
    expect(sut.numStr).toBe("");
  });

  it("evaluates if missing the operator", () => {
    sut.addNumber("2");
    sut.evaluate();

    expect(sut.num1).toBeCloseTo(2);
    expect(sut.op).toBe("");
    expect(sut.numStr).toBe("2");
  });

  it("evaluates if missing the second number", () => {
    sut.addNumber("2");
    sut.addOperator("^");
    sut.evaluate();

    expect(sut.num1).toBeCloseTo(2);
    expect(sut.op).toBe("^");
    expect(sut.numStr).toBe("");
  });
});

describe("ClearOutput", () => {
  it("clears if empty", () => {
    sut.clearOutput();

    expect(sut.numStr).toBe("");
    expect(sut.num1).toBeCloseTo(0);
    expect(sut.op).toBe("");
  });

  it("clears after the first number", () => {
    sut.addNumber("6");
    sut.clearOutput();

    expect(sut.numStr).toBe("");
    expect(sut.num1).toBeCloseTo(0);
    expect(sut.op).toBe("");
  });

  it("clears after the operator", () => {
    sut.addNumber("6");
    sut.addNumber("/");
    sut.clearOutput();

    expect(sut.numStr).toBe("");
    expect(sut.num1).toBeCloseTo(0);
    expect(sut.op).toBe("");
  });

  it("clears after the second number", () => {
    sut.addNumber("6");
    sut.addOperator("/");
    sut.addNumber("6");
    sut.clearOutput();

    expect(sut.numStr).toBe("");
    expect(sut.num1).toBeCloseTo(0);
    expect(sut.op).toBe("");
  });

  it("clears after evaluate", () => {
    sut.addNumber("6");
    sut.addOperator("/");
    sut.addNumber("6");
    sut.evaluate();
    sut.clearOutput();

    expect(sut.numStr).toBe("");
    expect(sut.num1).toBeCloseTo(0);
    expect(sut.op).toBe("");
  });
});
