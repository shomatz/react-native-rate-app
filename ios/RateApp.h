
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNRateAppSpec.h"

@interface RateApp : NSObject <NativeRateAppSpec>
#else
#import <React/RCTBridgeModule.h>

@interface RateApp : NSObject <RCTBridgeModule>
#endif

@end