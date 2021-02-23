import { NativeModules } from 'react-native';

type AppleMapKitDirectionsType = {
  multiply(a: number, b: number): Promise<number>;
};

const { AppleMapKitDirections } = NativeModules;

export default AppleMapKitDirections as AppleMapKitDirectionsType;
