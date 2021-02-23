import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';

import AppleMapKitDirections, {
  TRNMapKitResponse,
} from 'react-native-apple-map-kit-directions';

export default function App() {
  const [result, setResult] = React.useState<TRNMapKitResponse>();

  React.useEffect(() => {
    AppleMapKitDirections.getRouteDetail(
      {
        latitude: 37.3349,
        longitude: -122.00902,
      },
      {
        latitude: 37.327943,
        longitude: -121.938195,
      },
      'car'
    )
      .then(setResult)
      .catch((err) => console.warn(err));
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {JSON.stringify(result)}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
