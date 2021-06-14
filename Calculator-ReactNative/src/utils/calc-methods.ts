import { SetStateAction } from "react";

export let num1: number = 0;
export let op: string = "";
export let numStr: string = "";

export const resetVariables = (): void => {
  num1 = 0;
  op = "";
  numStr = "";
};

export const clearOutput = (): SetStateAction<string> => {
  numStr = "";
  num1 = 0;
  op = "";
  return "";
};

export const addNumber = (
  key: string,
  output: string = ""
): SetStateAction<string> => {
  numStr += key;
  return output + key;
};

export const addOperator = (
  key: string,
  output: string = ""
): SetStateAction<string> => {
  const num: number = parseFloat(numStr);
  if (isNaN(num)) return output;

  num1 = num;
  op = key;
  numStr = "";
  return `${output} ${key} `;
};

export const invertNumber = (): SetStateAction<string> => {
  if (numStr.startsWith("-")) {
    numStr = numStr.substring(1);
  } else {
    numStr = `-${numStr}`;
  }

  return numStr;
};

export const evaluate = (output: string = ""): SetStateAction<string> => {
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
