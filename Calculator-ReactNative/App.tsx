import { Platform, StatusBar, StyleSheet, ViewStyle } from "react-native";
import { SafeAreaProvider, SafeAreaView } from "react-native-safe-area-context";
import Calculator from "./src/Calculator";

export default function App() {
  return (
    // Avoid the notch on iOS
    <SafeAreaProvider>
      <SafeAreaView style={styles.container}>
        {/* Top bar on iOS and Android */}
        <StatusBar />
        <Calculator />
      </SafeAreaView>
    </SafeAreaProvider>
  );
}

// ViewStyle | TextStyle | ImageStyle
const styles: { container: ViewStyle } = StyleSheet.create({
  container: {
    // Avoid the notch on Android
    paddingTop: Platform.OS === "android" ? StatusBar.currentHeight : 0,
    flex: 1, // make the height 100%
  },
});
