#import "RateApp.h"
#import <StoreKit/StoreKit.h>

static NSString *const kNoActiveSceneError = @"no_active_scene";

@implementation RateApp
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(requestReview:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    UIWindowScene *scene = [self findActiveScene];
    if (scene) {
        [SKStoreReviewController requestReviewInScene:scene];
        resolve(@(YES));
    } else {
        reject(kNoActiveSceneError, @"No active scene found", nil);
    }
}

- (UIWindowScene *) findActiveScene {
    for (UIWindowScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if (scene.activationState == UISceneActivationStateForegroundActive) {
            return scene;
        }
    }
    return nil;
}

// Don't compile this code when we build for the old architecture.
#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeRateAppSpecJSI>(params);
}
#endif

@end