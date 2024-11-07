#import "RateApp.h"
#import <StoreKit/StoreKit.h>

static NSString *const kNoActiveSceneError = @"no_active_scene";

@implementation RateApp
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(requestReview:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindowScene *scene;
        for (UIWindowScene *windowScene in UIApplication.sharedApplication.connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                scene = windowScene;
                break;
            }
        }
        if (scene) {
            [SKStoreReviewController requestReviewInScene:scene];
            resolve(@(YES));
        } else {
            reject(kNoActiveSceneError, @"No active scene found", nil);
        }
    });
}

- (void)requestReviewAppGallery:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
}


- (void)requestReviewGalaxyStore:(NSString *)androidPackageName resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
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
