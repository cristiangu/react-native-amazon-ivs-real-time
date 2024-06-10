#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(AmazonIvsRealTimeViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(customerCode, NSString)
RCT_EXPORT_VIEW_PROPERTY(apiKey, NSString)
RCT_EXPORT_VIEW_PROPERTY(isMuted, BOOL)


//RCT_EXPORT_VIEW_PROPERTY(onPressed, RCTBubblingEventBlock)

@end
