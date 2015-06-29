//
//  DCiAdInMobiBanner.m
//
//  Created by Dolice on 2015/06/29.
//  Copyright (c) 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCiAdInMobiBanner.h"

@implementation DCiAdInMobiBanner

@synthesize iAdView                   = _iAdView;
@synthesize inMobiView                = _inMobiView;
@synthesize currentRootViewController = _currentRootViewController;
@synthesize loaded                    = _loaded;

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

#pragma mark Initialize

- (void)initAdView
{
    self.iAdView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    self.iAdView.backgroundColor = [UIColor clearColor];
    self.iAdView.delegate = self;
}

#pragma mark - public method

- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos
{
    bannerY = yPos;
    if (![viewController isEqual:self.currentRootViewController]) {
        self.currentRootViewController = viewController;
        if (isiAdFailed) {
            // InMobi
            [self showInMobiBanner:viewController.view];
        } else if (isInMobiFailed) {
            // iAd
            [self showiAdBanner:viewController.view];
        } else {
            // iAd
            [self showiAdBanner:viewController.view];
        }
    } else if (isiAdFailed) {
        // iAdの取得に失敗した場合は InMobiに切り替える
        [self showInMobiBanner:viewController.view];
    } else if (isInMobiFailed) {
        // InMobiの取得に失敗した場合は iAdに切り替える
        [self showiAdBanner:viewController.view];
    } else {
        // iAd
        [self showiAdBanner:viewController.view];
    }
}

// バナー削除
- (void)removeAdBanner
{
    if (self.iAdView.superview) {
        [self.iAdView removeFromSuperview];
    }
    
    if (self.inMobiView.superview) {
        [self.inMobiView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.iAdView.superview) {
        self.iAdView.hidden = hidden;
    }
    
    if (self.inMobiView.superview) {
        self.inMobiView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.iAdView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.iAdView atIndex:subviewsCount + 1];
    }
    
    if (self.inMobiView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.inMobiView atIndex:subviewsCount + 1];
    }
}

#pragma mark - iAd Banner

- (void)showiAdBanner:(UIView *)view
{
    [self removeAdBanner];
    
    CGRect iAdViewFrame = self.iAdView.frame;
    iAdViewFrame.origin = CGPointMake(0, bannerY);
    self.iAdView.frame = iAdViewFrame;
    [view addSubview:self.iAdView];
}

#pragma mark - InMobi Banner

- (void)showInMobiBanner:(UIView *)targetView
{
    [self removeAdBanner];
    
    CGFloat const BANNER_WIDTH  = 320;
    CGFloat const BANNER_HEIGHT = 50;
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat bannerX     = roundf((screenWidth / 2) - (BANNER_WIDTH / 2));
    
    self.inMobiView = [[IMBanner alloc] initWithFrame:CGRectMake(bannerX, bannerY, BANNER_WIDTH, BANNER_HEIGHT)
                                                appId:INMOBI_UNIT_ID adSize:IM_UNIT_320x50];
    self.inMobiView.delegate = self;
    [targetView addSubview:self.inMobiView];
    
    [self.inMobiView loadBanner];
}

#pragma mark - iAd delegate method

- (void)bannerViewWillLoadAd:(ADBannerView *)banner
{
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    _loaded = YES;
    
    isiAdFailed = !_loaded;
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    _loaded = NO;
    
    isiAdFailed = _loaded;
    
    // バナー再読み込み
    [self showAdBanner:self.currentRootViewController yPos:bannerY];
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
}

#pragma mark - InMobi delegate method

- (void)bannerDidReceiveAd:(IMBanner *)banner
{
    _loaded = YES;
    
    isInMobiFailed = !_loaded;
}

- (void)banner:(IMBanner *)banner didFailToReceiveAdWithError:(IMError *)error
{
    _loaded = NO;
    
    isInMobiFailed = !_loaded;
    
    // バナー再読み込み
    [self showAdBanner:self.currentRootViewController yPos:bannerY];
}

- (void)bannerDidInteract:(IMBanner *)banner withParams:(NSDictionary *)dictionary
{
}

- (void)bannerWillPresentScreen:(IMBanner *)banner
{
}

- (void)bannerWillDismissScreen:(IMBanner *)banner
{
}

- (void)bannerDidDismissScreen:(IMBanner *)banner
{
}

- (void)bannerWillLeaveApplication:(IMBanner *)banner
{
}

@end
