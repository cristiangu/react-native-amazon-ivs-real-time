import * as React from 'react';

import { StyleSheet, Text, TouchableOpacity, View } from 'react-native';
import { AmazonIvsRealTimeView } from 'react-native-amazon-ivs-real-time';

export default function App() {
  const [isMuted, setIsMuted] = React.useState(false);
  return (
    <View style={styles.container}>
      <AmazonIvsRealTimeView
        apiKey="//redacted"
        customerCode="//redacted"
        isMuted={isMuted}
        style={styles.box}
      />
      <View style={styles.mute}>
        <TouchableOpacity onPress={() => setIsMuted(!isMuted)}>
          <Text style={styles.muteLabel}>Toggle muted</Text>
        </TouchableOpacity>
      </View>
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
    width: '100%',
    height: '100%',
  },
  mute: { position: 'absolute', top: 100, left: 0 },
  muteLabel: { color: 'red' },
});
