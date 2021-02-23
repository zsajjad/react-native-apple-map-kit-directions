#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(AppleMapKitDirections, NSObject)

RCT_EXTERN_METHOD(getRouteDetail:
                  (NSDictionary *)origin
                  toDestination:(NSDictionary *)destination
                  byTransitType:(NSString *)transitType
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)

@end
