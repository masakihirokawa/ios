//
//  DCiAdBanner.m
//  DoliceGraphicArtsWallpaper
//
//  Created by Dolice on 2014/06/16.
//  Copyright (c) 2014年 Masaki Hirokawa. All rights reserved.
//

#import "DCiAdBanner.h"

@implementation DCiAdBanner

@synthesize iAdView                   = _iAdView;
@synthesize currentRootViewController = _currentRootViewController;

#pragma mark - Shared Manager

static id sharedInstance = nil;

+ (id)sharedManager
{
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
			[sharedInstance initAdView];
        }
    }
	return sharedInstance;
}

#pragma mark Init Ad View

- (void)initAdView
{
    self.iAdView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    self.iAdView.backgroundColor = [UIColor clearColor];
	self.iAdView.delegate = self;
}

#pragma mark - public method

- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos
{
    if (![viewController isEqual:self.currentRootViewController]) {
        self.currentRootViewController = viewController;
        [self showIADBanner:viewController.view yPos:yPos];
    }
}

// バナー削除
- (void)removeAdBanner
{
    if (self.iAdView.superview) {
        [self.iAdView removeFromSuperview];
    }
}

#pragma mark - iAd Banner

- (void)showIADBanner:(UIView *)view yPos:(CGFloat)yPos
{
    [self removeAdBanner];
    
    CGRect iAdViewFrame = self.iAdView.frame;
    iAdViewFrame.origin = CGPointMake(0, yPos);
    self.iAdView.frame = iAdViewFrame;
    
    [view addSubview:self.iAdView];
}

#pragma mark - delegate method

- (void)bannerViewWillLoadAd:(ADBannerView *)banner
{
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    isiAdFailed = YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
}

@end