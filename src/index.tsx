import { NativeModules } from 'react-native';

type RNMapKitLocation = {
  latitude: number;
  longitude: number;
};

export type TRNMapKitResponse = {
  name: string;
  distance: number;
  expectedTravelTime: number;
  advisoryNotices: string[];
};

type RNMapKitTransitType = 'car' | 'walk' | 'transit';

type AppleMapKitDirectionsType = {
  getRouteDetail(
    origin: RNMapKitLocation,
    destination: RNMapKitLocation,
    transitType: RNMapKitTransitType
  ): Promise<TRNMapKitResponse>;
};

const { AppleMapKitDirections } = NativeModules;

export default AppleMapKitDirections as AppleMapKitDirectionsType;
