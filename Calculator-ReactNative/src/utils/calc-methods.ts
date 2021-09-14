import { SetStateAction } from "react";

export let num1: number = 0;
export let op: string = "";
export let numStr: string = "0";

export const resetVariables = (): void => {
  num1 = 0;
  op = "";
  numStr = "0";
};

export const clearOutput = (): SetStateAction<string> => {
  numStr = "0";
  num1 = 0;
  op = "";
  return "0";
};

export const addNumber = (
  key: string,
  output: string = "0"
): SetStateAction<string> => {
  // Replace a 0 with the number
  if (numStr === "0") {
    numStr = key;
  } else if (numStr === "-0") {
    numStr = `-${key}`;
  } else {
    numStr += key;
  }

  if (output === "0") {
    return key;
  } else if (output === "-0") {
    return `-${key}`;
  } else {
    return output + key;
  }
};

export const addDecimal = (output: string = "0"): SetStateAction<string> => {
  // Don't add another decimal point if the number already contains one
  if (!numStr.includes(".")) {
    numStr += ".";
    return output + ".";
  }

  return output;
};

export const addOperator = (
  key: string,
  output: string = "0"
): SetStateAction<string> => {
  // Simplify the left side of the expression before chaining additional operators
  let newOutput = evaluate(output);

  const num: number = parseFloat(numStr);
  if (isNaN(num)) return newOutput;

  num1 = num;
  op = key;
  numStr = "";
  return `${num} ${key} `;
};

export const invertNumber = (): SetStateAction<string> => {
  if (numStr.startsWith("-")) {
    numStr = numStr.substring(1);
  } else {
    numStr = `-${numStr}`;
  }

  if (op !== "") {
    // Negate the right side of the expression
    return `${num1} ${op} ${numStr}`;
  } else {
    return numStr;
  }
};

export const backspace = (output: string = "0"): SetStateAction<string> => {
  if (numStr !== "") {
    numStr = numStr.slice(0, -1);

    if (numStr === "") {
      numStr = "0"; // show 0 when there's no text
    }
  } else if (op !== "") {
    // Undo addOperator after deleting an operator
    numStr = num1.toString();
    num1 = 0;
    op = "";
  }

  if (output !== "") {
    let newOutput = output;

    if (output.charAt(output.length - 1) === " ") {
      newOutput = output.slice(0, -3); // remove the spaces in between the operator
    } else {
      newOutput = output.slice(0, -1);
    }

    return newOutput === "" ? "0" : newOutput;
  }

  return output;
};

export const evaluate = (output: string = "0"): SetStateAction<string> => {
  const num2 = parseFloat(numStr);
  if (isNaN(num2)) return output;
  let result: number;

  switch (op) {
    case "+":
      result = num1 + num2;
      break;
    case "-":
      result = num1 - num2;
      break;
    case "*":
      result = num1 * num2;
      break;
    case "/":
      result = num1 / num2;
      break;
    case "%":
      result = num1 % num2;
      break;
    case "^":
      result = num1 ** num2;
      break;
    default:
      result = num2;
  }

  num1 = result;
  numStr = result.toString();
  op = "";
  return numStr;
};
