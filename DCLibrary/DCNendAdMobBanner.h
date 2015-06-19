//
//  DCNendAdMobBanner.h
//
//  Created by Dolice on 2015/06/19.
//  Copyright (c) 2015 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NADView.h"

@import GoogleMobileAds;

@interface DCNendAdMobBanner : NSObject <NADViewDelegate, GADBannerViewDelegate> {
    CGFloat bannerY;
    BOOL    isNendFailed;
    BOOL    isAdMobFailed;
}

#pragma mark - property
@property (nonatomic, strong) NADView          *nendView;
@property (nonatomic, strong) GADBannerView    *gadView;
@property (nonatomic, strong) UIViewController *currentRootViewController;
@property (nonatomic, assign) BOOL             loaded;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;

@end