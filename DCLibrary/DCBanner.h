//
//  DCBanner.h
//
//  Created by Masaki Hirokawa on 2013/09/12.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADBannerView.h"
#import <iAd/iAd.h>

@interface DCBanner : NSObject <ADBannerViewDelegate, GADBannerViewDelegate> {
    BOOL isiAdFailed;
    BOOL isAdMobFailed;
}

#pragma mark - property
@property (nonatomic, strong) ADBannerView     *iAdView;
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
