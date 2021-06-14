import React, { useState } from "react";
import { StyleSheet, Text, View } from "react-native";
import { clearOutput, addNumber, addOperator, invertNumber, evaluate } from "./utils/calc-methods";
import RoundButton from "./RoundButton";

const Calculator: React.FC = () => {
    const [output, setOutput] = useState<string>("");

    return (
        <View style={styles.containerVertical}>
            <Text style={styles.output} numberOfLines={2} ellipsizeMode="tail">{output}</Text>
            <View style={styles.containerHorizontal}>
                <RoundButton text="^" color="black" onPress={() => setOutput(addOperator("^", output))} />
                <RoundButton text="π" color="black" onPress={() => { }} />
                <RoundButton text="ln" color="black" onPress={() => { }} />
                <RoundButton text="clear" color="red" onPress={() => setOutput(clearOutput())} />
            </View>
            <View style={styles.containerHorizontal}>
                <RoundButton text="(" color="black" onPress={() => { }} />
                <RoundButton text=")" color="black" onPress={() => { }} />
                <RoundButton text="%" color="green" onPress={() => setOutput(addOperator("%", output))} />
                <RoundButton text="/" color="green" onPress={() => setOutput(addOperator("/", output))} />
            </View>
            <View style={styles.containerHorizontal}>
                <RoundButton text="7" color="orange" onPress={() => setOutput(addNumber("7", output))} />
                <RoundButton text="8" color="orange" onPress={() => setOutput(addNumber("8", output))} />
                <RoundButton text="9" color="orange" onPress={() => setOutput(addNumber("9", output))} />
                <RoundButton text="*" color="green" onPress={() => setOutput(addOperator("*", output))} />
            </View>
            <View style={styles.containerHorizontal}>
                <RoundButton text="4" color="orange" onPress={() => setOutput(addNumber("4", output))} />
                <RoundButton text="5" color="orange" onPress={() => setOutput(addNumber("5", output))} />
                <RoundButton text="6" color="orange" onPress={() => setOutput(addNumber("6", output))} />
                <RoundButton text="-" color="green" onPress={() => setOutput(addOperator("-", output))} />
            </View>
            <View style={styles.containerHorizontal}>
                <RoundButton text="1" color="orange" onPress={() => setOutput(addNumber("1", output))} />
                <RoundButton text="2" color="orange" onPress={() => setOutput(addNumber("2", output))} />
                <RoundButton text="3" color="orange" onPress={() => setOutput(addNumber("3", output))} />
                <RoundButton text="+" color="green" onPress={() => setOutput(addOperator("+", output))} />
            </View>
            <View style={styles.containerHorizontal}>
                <RoundButton text="0" color="orange" onPress={() => setOutput(addNumber("0", output))} />
                <RoundButton text="." color="black" onPress={() => setOutput(addNumber(".", output))} />
                <RoundButton text="(-)" color="black" onPress={() => setOutput(invertNumber())} />
                <RoundButton text="=" color="blue" onPress={() => setOutput(evaluate(output))} />
            </View>
        </View>
    );
};

const styles: StyleSheet.NamedStyles<any> = StyleSheet.create({
    containerVertical: {
        display: "flex",
        justifyContent: "space-around",
        flex: 1
    },

    output: {
        textAlign: "right",
        fontSize: 50,
        marginLeft: "5%",
        marginRight: "5%",
        height: 125 // keep the height as-is when the output is empty
    },

    containerHorizontal: {
        display: "flex",
        justifyContent: "space-around",
        flexDirection: "row"
    }
});

export default Calculator;
