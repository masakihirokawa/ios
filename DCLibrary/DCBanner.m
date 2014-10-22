//
//  DCBanner.m
//
//  Created by Masaki Hirokawa on 2013/09/12.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCBanner.h"

@implementation DCBanner

@synthesize iAdView                   = _iAdView;
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
    if (![viewController isEqual:self.currentRootViewController]) {
        self.currentRootViewController = viewController;
        if (isAdMobFailed) {
            // iAd
            [self showIADBanner:viewController.view yPos:yPos];
        } else if (isiAdFailed) {
            // AdMob
            [self showGADBanner:viewController.view yPos:yPos];
        } else {
            // AdMob
            [self showGADBanner:viewController.view yPos:yPos];
        }
    } else if (isAdMobFailed) {
        // AdMobの取得に失敗した場合は iAdに切り替える
        [self showIADBanner:viewController.view yPos:yPos];
    } else if (isiAdFailed) {
        // iAdの取得に失敗した場合は AdMobに切り替える
        [self showGADBanner:viewController.view yPos:yPos];
    } else {
        // AdMob
        [self showGADBanner:viewController.view yPos:yPos];
    }
}

// バナー削除
- (void)removeAdBanner
{
    if (self.iAdView.superview) {
        [self.iAdView removeFromSuperview];
    }
    
    if (self.gadView.superview) {
        [self.gadView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.iAdView.superview) {
        self.iAdView.hidden = hidden;
    }
    
    if (self.gadView.superview) {
        self.gadView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.iAdView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.iAdView atIndex:subviewsCount + 1];
    }
    
    if (self.gadView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.gadView atIndex:subviewsCount + 1];
    }
}

#pragma mark - AdMob Banner

- (void)showGADBanner:(UIView *)targetView yPos:(CGFloat)yPos
{
    if (!self.gadView) {
        self.gadView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthPortraitWithHeight(GAD_SIZE_320x50.height)];
        self.gadView.adUnitID = GAD_UNIT_ID;
        self.gadView.delegate = self;
        [self loadGADBanner:targetView yPos:yPos];
    }
    
    if (self.iAdView.superview) {
        [self.iAdView removeFromSuperview];
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

#pragma mark - iAd Banner

- (void)showIADBanner:(UIView *)view yPos:(CGFloat)yPos
{
    [self removeAdBanner];
    
    CGRect iAdViewFrame = self.iAdView.frame;
    iAdViewFrame.origin = CGPointMake(0, yPos);
    self.iAdView.frame = iAdViewFrame;
    
    [view addSubview:self.iAdView];
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
    [self showAdBanner:self.currentRootViewController yPos:self.gadView.frame.origin.y];
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
    [self showAdBanner:self.currentRootViewController yPos:self.iAdView.frame.origin.y];
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
}

@end