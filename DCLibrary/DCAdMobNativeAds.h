//
//  DCAdMobNativeAds.h
//
//  Created by Dolice on 2016/08/16.
//  Copyright © 2016 Dolice. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMobileAds;

@interface DCAdMobNativeAds : NSObject <GADNativeExpressAdViewDelegate> {
    GADNativeExpressAdView *nativeExpressAdView;
}

#pragma mark - property
@property (nonatomic, strong) GADNativeExpressAdView *nativeExpressAdView;

#pragma mark - public method
+ (id)sharedManager;
- (void)showNativeAd:(UIViewController *)viewController targetView:(UIView *)targetView frame:(CGRect)frame;
- (UIView *)nativeAd:(UIViewController *)viewController frame:(CGRect)frame;

@end
