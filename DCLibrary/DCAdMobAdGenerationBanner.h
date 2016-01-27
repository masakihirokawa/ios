//
//  DCAdMobAdGenerationBanner.h
//
//  Created by Dolice on 2015/09/30.
//  Copyright (c) 2015 Dolice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ADG/ADGManagerViewController.h>

@import GoogleMobileAds;

@interface DCAdMobAdGenerationBanner : NSObject <GADBannerViewDelegate, ADGManagerViewControllerDelegate> {
    CGFloat bannerY;
    BOOL    isAdMobFailed;
    BOOL    isAdGenerationFailed;
}

#pragma mark - property
@property (nonatomic, strong) GADBannerView            *gadView;
@property (nonatomic, strong) ADGManagerViewController *adGenerationView;
@property (nonatomic, strong) UIViewController         *currentRootViewController;
@property (nonatomic, assign) BOOL                     loaded;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;

@end
