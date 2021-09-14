import React, { useState } from "react";
import {
  ScrollView,
  StyleSheet,
  Text,
  useWindowDimensions,
  View,
} from "react-native";
import {
  clearOutput,
  addNumber,
  addOperator,
  invertNumber,
  evaluate,
  backspace,
  addDecimal,
} from "./utils/calc-methods";
import RoundButton from "./RoundButton";

const Calculator: React.FC = () => {
  const [output, setOutput] = useState<string>("0");
  const { height } = useWindowDimensions();

  return (
    <View style={styles.containerVertical}>
      <Text
        style={[
          styles.output,
          {
            fontSize: 0.05 * height,
            height: 0.15 * height, // keep the height as-is when the output is empty
          },
        ]}
        numberOfLines={2}
        ellipsizeMode="tail"
      >
        {output}
      </Text>
      <ScrollView>
        <View
          style={[
            styles.containerVertical,
            {
              // If there's room, extend the buttons to the bottom of the screen
              minHeight: 0.85 * height,
            },
          ]}
        >
          <View style={styles.containerHorizontal}>
            <RoundButton
              text="^"
              color="black"
              onPress={() => setOutput(addOperator("^", output))}
            />
            <RoundButton text="π" color="black" onPress={() => {}} />
            <RoundButton
              text="↩︎"
              color="red"
              onPress={() => setOutput(backspace(output))}
            />
            <RoundButton
              text="clear"
              color="red"
              onPress={() => setOutput(clearOutput())}
            />
          </View>
          <View style={styles.containerHorizontal}>
            <RoundButton text="(" color="black" onPress={() => {}} />
            <RoundButton text=")" color="black" onPress={() => {}} />
            <RoundButton
              text="%"
              color="green"
              onPress={() => setOutput(addOperator("%", output))}
            />
            <RoundButton
              text="/"
              color="green"
              onPress={() => setOutput(addOperator("/", output))}
            />
          </View>
          <View style={styles.containerHorizontal}>
            <RoundButton
              text="7"
              color="orange"
              onPress={() => setOutput(addNumber("7", output))}
            />
            <RoundButton
              text="8"
              color="orange"
              onPress={() => setOutput(addNumber("8", output))}
            />
            <RoundButton
              text="9"
              color="orange"
              onPress={() => setOutput(addNumber("9", output))}
            />
            <RoundButton
              text="*"
              color="green"
              onPress={() => setOutput(addOperator("*", output))}
            />
          </View>
          <View style={styles.containerHorizontal}>
            <RoundButton
              text="4"
              color="orange"
              onPress={() => setOutput(addNumber("4", output))}
            />
            <RoundButton
              text="5"
              color="orange"
              onPress={() => setOutput(addNumber("5", output))}
            />
            <RoundButton
              text="6"
              color="orange"
              onPress={() => setOutput(addNumber("6", output))}
            />
            <RoundButton
              text="-"
              color="green"
              onPress={() => setOutput(addOperator("-", output))}
            />
          </View>
          <View style={styles.containerHorizontal}>
            <RoundButton
              text="1"
              color="orange"
              onPress={() => setOutput(addNumber("1", output))}
            />
            <RoundButton
              text="2"
              color="orange"
              onPress={() => setOutput(addNumber("2", output))}
            />
            <RoundButton
              text="3"
              color="orange"
              onPress={() => setOutput(addNumber("3", output))}
            />
            <RoundButton
              text="+"
              color="green"
              onPress={() => setOutput(addOperator("+", output))}
            />
          </View>
          <View style={styles.containerHorizontal}>
            <RoundButton
              text="0"
              color="orange"
              onPress={() => setOutput(addNumber("0", output))}
            />
            <RoundButton
              text="."
              color="black"
              onPress={() => setOutput(addDecimal(output))}
            />
            <RoundButton
              text="(-)"
              color="black"
              onPress={() => setOutput(invertNumber())}
            />
            <RoundButton
              text="="
              color="blue"
              onPress={() => setOutput(evaluate(output))}
            />
          </View>
        </View>
      </ScrollView>
    </View>
  );
};

const styles: StyleSheet.NamedStyles<any> = StyleSheet.create({
  containerVertical: {
    display: "flex",
    justifyContent: "space-around",
    flex: 1,
  },

  output: {
    textAlign: "right",
    marginLeft: "5%",
    marginRight: "5%",
  },

  containerHorizontal: {
    display: "flex",
    justifyContent: "space-around",
    flexDirection: "row",
  },
});

export default Calculator;
