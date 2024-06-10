import {
  requireNativeComponent,
  UIManager,
  Platform,
  type ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-amazon-ivs-real-time' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

type AmazonIvsRealTimeProps = {
  customerCode: string;
  apiKey: string;
  isMuted: boolean;
  //onPressed?: (event: any) => void;
  style: ViewStyle;
};

const ComponentName = 'AmazonIvsRealTimeView';

export const AmazonIvsRealTimeView =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<AmazonIvsRealTimeProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
