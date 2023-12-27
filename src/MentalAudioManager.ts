import { NativeModules, NativeEventEmitter } from 'react-native';

const { MentalAudioManagerModule } = NativeModules;

type AudioSessionRouteChangeReason = string;
type AudioSessionRoute = string;

class MentalAudioManager {
  private static eventEmitter = new NativeEventEmitter(MentalAudioManagerModule);

  static onAudioSessionRouteDidChange(callback: (reason: AudioSessionRouteChangeReason, previousRoute: AudioSessionRoute) => void): void {
    this.eventEmitter.addListener('onAudioSessionRouteDidChange', callback);
  }
}

export default MentalAudioManager;
