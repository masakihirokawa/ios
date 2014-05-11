//
//  DCAdMobBanner.m
//
//  Created by Masaki Hirokawa on 2014/02/23.
//  Copyright (c) 2014 Masaki Hirokawa. All rights reserved.
//

#import "DCAdMobBanner.h"

@implementation DCAdMobBanner

@synthesize gadView                   = _gadView;
@synthesize currentRootViewController = _currentRootViewController;

#pragma mark - Shared Manager

static id sharedInstance = nil;

+ (id)sharedManager
{
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    }
	return sharedInstance;
}

#pragma mark - public method

// バナー表示
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos
{
    self.currentRootViewController = viewController;
    [self showGADBanner:viewController.view yPos:yPos];
}

// バナー削除
- (void)removeAdBanner
{
    if (self.gadView.superview) {
        [self.gadView removeFromSuperview];
    }
}

#pragma mark - GAD Banner

- (void)showGADBanner:(UIView *)targetView yPos:(CGFloat)yPos
{
    if (!self.gadView) {
        self.gadView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
        self.gadView.adUnitID = GAD_UNIT_ID;
        [self loadGADBanner:targetView yPos:yPos];
    }
    if (![self.gadView.superview isEqual:targetView]) {
        [self.gadView removeFromSuperview];
        [self loadGADBanner:targetView yPos:yPos];
    }
}

- (void)loadGADBanner:(UIView *)view yPos:(CGFloat)yPos
{
    self.gadView.rootViewController = self.currentRootViewController;
    
    CGRect gadViewFrame = self.gadView.frame;
    gadViewFrame.origin = CGPointMake(0, yPos);
    self.gadView.frame = gadViewFrame;
    
    [view addSubview:self.gadView];
    [self.gadView loadRequest:[GADRequest request]];
}

@end
