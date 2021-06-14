import React from "react";
import { ColorValue, GestureResponderEvent, Pressable, StyleSheet, Text } from "react-native";

type RoundButtonProps = {
    text: string,
    color: ColorValue,
    onPress: (event: GestureResponderEvent) => void
};

const RoundButton: React.FC<RoundButtonProps> = ({ text, color, onPress }) => {
    return (
        <Pressable style={({ pressed }) => [
            styles.button,
            {
                backgroundColor: color,
                opacity: pressed ? 0.5 : 1
            }
        ]} onPress={onPress}>
            <Text style={styles.buttonText}>{text}</Text>
        </Pressable>
    );
};

const styles: StyleSheet.NamedStyles<any> = StyleSheet.create({
    button: {
        //cursor: "pointer",
        borderRadius: 100,
        width: 50,
        height: 50,
        justifyContent: "center"
    },

    buttonText: {
        color: "white",
        textAlign: "center"
    }
});

export default RoundButton;
