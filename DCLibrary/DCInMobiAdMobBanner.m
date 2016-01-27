//
//  DCInMobiAdMobBanner.m
//
//  Created by Dolice on 2015/06/19.
//  Copyright (c) 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCInMobiAdMobBanner.h"

@implementation DCInMobiAdMobBanner

@synthesize inMobiView                = _inMobiView;
@synthesize gadView                   = _gadView;
@synthesize currentRootViewController = _currentRootViewController;
@synthesize loaded                    = _loaded;

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

- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos
{
    bannerY = yPos;
    if (![viewController isEqual:self.currentRootViewController]) {
        self.currentRootViewController = viewController;
        if (isInMobiFailed) {
            // AdMob
            [self showAdMobBanner:viewController.view];
        } else if (isAdMobFailed) {
            // InMobi
            [self showInMobiBanner:viewController.view];
        } else {
            // InMobi
            [self showInMobiBanner:viewController.view];
        }
    } else if (isInMobiFailed) {
        // InMobiの取得に失敗した場合は AdMobに切り替える
        [self showAdMobBanner:viewController.view];
    } else if (isAdMobFailed) {
        // AdMobの取得に失敗した場合は InMobiに切り替える
        [self showInMobiBanner:viewController.view];
    } else {
        // InMobi
        [self showInMobiBanner:viewController.view];
    }
}

// バナー削除
- (void)removeAdBanner
{
    if (self.inMobiView.superview) {
        [self.inMobiView removeFromSuperview];
    }
    
    if (self.gadView.superview) {
        [self.gadView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.inMobiView.superview) {
        self.inMobiView.hidden = hidden;
    }
    
    if (self.gadView.superview) {
        self.gadView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.inMobiView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.inMobiView atIndex:subviewsCount + 1];
    }
    
    if (self.gadView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.gadView atIndex:subviewsCount + 1];
    }
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
                                          placementId:INMOBI_PLACEMENT_ID];
    self.inMobiView.delegate = self;
    [targetView addSubview:self.inMobiView];
    
    [self.inMobiView load];
}

#pragma mark - AdMob Banner

- (void)showAdMobBanner:(UIView *)targetView
{
    if (!self.gadView) {
        self.gadView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
        //self.gadView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthPortraitWithHeight(GAD_SIZE_320x50.height)];
        self.gadView.adUnitID = GAD_UNIT_ID;
        self.gadView.delegate = self;
        [self loadAdMobBanner:targetView];
    }
    
    if (self.inMobiView.superview) {
        [self.inMobiView removeFromSuperview];
    }
    
    if (![self.gadView.superview isEqual:targetView]) {
        [self.gadView removeFromSuperview];
        [self loadAdMobBanner:targetView];
    }
}

- (void)loadAdMobBanner:(UIView *)view
{
    self.gadView.rootViewController = self.currentRootViewController;
    
    CGFloat const screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat const bannerX     = roundf((screenWidth / 2) - (kGADAdSizeBanner.size.width / 2));
    
    CGRect gadViewFrame = self.gadView.frame;
    gadViewFrame.origin = CGPointMake(bannerX, bannerY);
    self.gadView.frame = gadViewFrame;
    
    [view addSubview:self.gadView];
    [self.gadView loadRequest:[GADRequest request]];
}

#pragma mark - InMobi delegate method

- (void)bannerDidFinishLoading:(IMBanner *)banner
{
    _loaded = YES;
    
    isInMobiFailed = !_loaded;
}

- (void)banner:(IMBanner *)banner didFailToLoadWithError:(IMRequestStatus *)error
{
    _loaded = NO;
    
    isInMobiFailed = !_loaded;
    
    // バナー再読み込み
    [self showAdBanner:self.currentRootViewController yPos:bannerY];
}

- (void)banner:(IMBanner *)banner didInteractWithParams:(NSDictionary *)params
{
}

- (void)userWillLeaveApplicationFromBanner:(IMBanner *)banner
{
}

- (void)bannerWillPresentScreen:(IMBanner *)banner
{
}

- (void)bannerDidPresentScreen:(IMBanner *)banner
{
}

- (void)bannerWillDismissScreen:(IMBanner *)banner
{
}

- (void)bannerDidDismissScreen:(IMBanner *)banner
{
}

- (void)banner:(IMBanner *)banner rewardActionCompletedWithRewards:(NSDictionary *)rewards
{
}

#pragma mark - AdMob delegate method

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    _loaded = YES;
    
    isAdMobFailed = !_loaded;
}
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
{
    _loaded = NO;
    
    isAdMobFailed = !_loaded;
    
    // バナー再読み込み
    [self showAdBanner:self.currentRootViewController yPos:bannerY];
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView
{
}

- (void)adViewDidDismissScreen:(GADBannerView *)bannerView
{
}

- (void)adViewWillDismissScreen:(GADBannerView *)bannerView
{
}

- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView
{
}

@end
