#import "MentalAudioManager.h"
#import <AVFoundation/AVFoundation.h>

@implementation MentalAudioManager

RCT_EXPORT_MODULE(MentalAudioManagerModule);

- (NSArray<NSString *> *)supportedEvents {
  return @[@"onAudioSessionRouteDidChange"];
}

- (instancetype)init {
  self = [super init];
  if (self) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioSessionRouteChanged:)
                                                 name:AVAudioSessionRouteChangeNotification
                                               object:nil];
  }
  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)audioSessionRouteChanged:(NSNotification *)notification {
  NSDictionary *userInfo = notification.userInfo;
  NSInteger reasonValue = [[userInfo valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
  AVAudioSessionRouteDescription *previousRoute = [userInfo objectForKey:AVAudioSessionRouteChangePreviousRouteKey];
  
  [self sendEventWithName:@"onAudioSessionRouteDidChange" body:@{@"reason": @(reasonValue), @"previousRoute": previousRoute}];
}

@end
