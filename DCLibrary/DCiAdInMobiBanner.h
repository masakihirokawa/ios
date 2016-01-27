//
//  DCiAdInMobiBanner.h
//
//  Created by Dolice on 2015/06/29.
//  Copyright (c) 2015 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>
#import "IMBanner.h"
#import "IMBannerDelegate.h"
#import "IMRequestStatus.h"

@interface DCiAdInMobiBanner : NSObject <ADBannerViewDelegate, IMBannerDelegate> {
    CGFloat bannerY;
    BOOL    isiAdFailed;
    BOOL    isInMobiFailed;
}

#pragma mark - property
@property (nonatomic, strong) ADBannerView     *iAdView;
@property (nonatomic, strong) IMBanner         *inMobiView;
@property (nonatomic, strong) UIViewController *currentRootViewController;
@property (nonatomic, assign) BOOL             loaded;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;

@end
