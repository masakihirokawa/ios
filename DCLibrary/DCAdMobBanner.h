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
    BOOL    isAdMobFailed;
}

#pragma mark - property
@property (nonatomic, strong) GADBannerView    *gadView;
@property (nonatomic, strong) UIViewController *currentRootViewController;
@property (nonatomic, assign) BOOL             loaded;
@property (nonatomic, assign) BOOL             useSmartBanner;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos useSmartBanner:(BOOL)useSmartBanner;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;

@end
