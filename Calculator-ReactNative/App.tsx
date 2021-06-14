import React from "react";
import { Platform, SafeAreaView, StatusBar, StyleSheet, ViewStyle } from "react-native";
import Calculator from "./src/Calculator";

export default function App() {
  {/* Avoid the notch on iOS */ }
  return (
    <SafeAreaView style={styles.container}>
      {/* Top bar on iOS and Android */}
      <StatusBar />
      <Calculator />
    </SafeAreaView>
  );
}

// ViewStyle | TextStyle | ImageStyle
const styles: { container: ViewStyle } = StyleSheet.create({
  container: {
    // Avoid the notch on Android
    paddingTop: Platform.OS === "android" ? StatusBar.currentHeight : 0,
    flex: 1 // make the height 100%
  }
});
