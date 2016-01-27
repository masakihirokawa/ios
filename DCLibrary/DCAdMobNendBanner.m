//
//  DCAdMobNendBanner.m
//
//  Created by Dolice on 2015/06/29.
//  Copyright (c) 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCAdMobNendBanner.h"

@implementation DCAdMobNendBanner

@synthesize gadView                   = _gadView;
@synthesize nendView                  = _nendView;
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
        if (isAdMobFailed) {
            // Nend
            [self showNendBanner:viewController.view];
        } else if (isNendFailed) {
            // AdMob
            [self showAdMobBanner:viewController.view];
        } else {
            // AdMob
            [self showAdMobBanner:viewController.view];
        }
    } else if (isAdMobFailed) {
        // AdMobの取得に失敗した場合は Nendに切り替える
        [self showNendBanner:viewController.view];
    } else if (isNendFailed) {
        // Nendの取得に失敗した場合は AdMobに切り替える
        [self showAdMobBanner:viewController.view];
    } else {
        // AdMob
        [self showAdMobBanner:viewController.view];
    }
}

// バナー削除
- (void)removeAdBanner
{
    if (self.gadView.superview) {
        [self.gadView removeFromSuperview];
    }
    
    if (self.nendView.superview) {
        [self.nendView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.gadView.superview) {
        self.gadView.hidden = hidden;
    }
    
    if (self.nendView.superview) {
        self.nendView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.gadView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.gadView atIndex:subviewsCount + 1];
    }
    
    if (self.nendView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.nendView atIndex:subviewsCount + 1];
    }
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
    
    if (self.nendView.superview) {
        [self.nendView removeFromSuperview];
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

#pragma mark - Nend Banner

- (void)showNendBanner:(UIView *)targetView
{
    [self removeAdBanner];
    
    CGFloat const BANNER_WIDTH  = 320;
    CGFloat const BANNER_HEIGHT = 50;
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat bannerX     = roundf((screenWidth / 2) - (BANNER_WIDTH / 2));
    
    self.nendView = [[NADView alloc] initWithFrame:CGRectMake(bannerX, bannerY, BANNER_WIDTH, BANNER_HEIGHT)];
    self.nendView.isOutputLog = NO;
    self.nendView.nendApiKey = NEND_API_KEY;
    self.nendView.nendSpotID = NEND_SPOT_ID;
    self.nendView.delegate = self;
    [targetView addSubview:self.nendView];
    
    [self.nendView load];
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

#pragma mark - Nend delegate method

- (void)nadViewDidFinishLoad:(NADView *)adView
{
    _loaded = YES;
    
    isNendFailed = !_loaded;
}

- (void)nadViewDidFailToReceiveAd:(NADView *)adView
{
    _loaded = NO;
    
    isNendFailed = !_loaded;
    
    // バナー再読み込み
    [self showAdBanner:self.currentRootViewController yPos:bannerY];
}

@end
