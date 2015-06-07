//
//  DCInMobiiAdBanner.h
//
//  Created by Dolice on 2015/05/20.
//  Copyright (c) 2015 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>
#import "IMBanner.h"
#import "IMBannerDelegate.h"
#import "IMError.h"

@interface DCInMobiiAdBanner : NSObject <IMBannerDelegate, ADBannerViewDelegate> {
    CGFloat bannerY;
    BOOL    isInMobiFailed;
    BOOL    isiAdFailed;
}

#pragma mark - property
@property (nonatomic, strong) IMBanner         *inMobiView;
@property (nonatomic, strong) ADBannerView     *iAdView;
@property (nonatomic, strong) UIViewController *currentRootViewController;
@property (nonatomic, assign) BOOL             loaded;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;

@end
