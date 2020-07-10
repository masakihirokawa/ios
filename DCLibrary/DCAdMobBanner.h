//
//  DCAdMobBanner.h
//
//  Created by Masaki Hirokawa on 2014/02/23.
//  Copyright (c) 2014 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@import GoogleMobileAds;

@interface DCAdMobBanner : NSObject <GADBannerViewDelegate> {
    CGFloat bannerX;
    CGFloat bannerY;
    BOOL    isFailed;
}

#pragma mark - property
@property (nonatomic, strong) GADBannerView    *gadView;
@property (nonatomic, strong) UIViewController *currentRootViewController;
@property (nonatomic, assign) BOOL             loaded;
@property (nonatomic, assign) CGFloat          fadeInDuration;
@property (nonatomic, assign) BOOL             useAdaptiveBanner;
@property (nonatomic, assign) BOOL             useSmartBanner;
@property (nonatomic, assign) BOOL             usePersonalizedAds;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos fadeInDuration:(CGFloat)fadeInDuration
   useAdaptiveBanner:(BOOL)useAdaptiveBanner useSmartBanner:(BOOL)useSmartBanner usePersonalizedAds:(BOOL)usePersonalizedAds;
- (void)reloadAdBanner:(UIViewController *)viewController usePersonalizedAds:(BOOL)usePersonalizedAds;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;

@end
