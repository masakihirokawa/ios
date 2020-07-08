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

// バナー表示
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos fadeInDuration:(CGFloat)fadeInDuration
   useAdaptiveBanner:(BOOL)useAdaptiveBanner useSmartBanner:(BOOL)useSmartBanner usePersonalizedAds:(BOOL)usePersonalizedAds
{
    self.currentRootViewController = viewController;
    self.fadeInDuration = fadeInDuration;
    self.useAdaptiveBanner = useAdaptiveBanner;
    self.useSmartBanner = useSmartBanner;
    self.usePersonalizedAds = usePersonalizedAds;
    
    if (!self.useAdaptiveBanner && !self.useSmartBanner) {
        CGFloat const screenWidth = [[UIScreen mainScreen] bounds].size.width;
        bannerX = roundf((screenWidth / 2) - (kGADAdSizeBanner.size.width / 2));
    }
    bannerY = yPos;
    
    [self showAdMobBanner:viewController.view];
}

// バナーの再読み込み
- (void)reloadAdBanner:(UIViewController *)viewController usePersonalizedAds:(BOOL)usePersonalizedAds
{
    self.currentRootViewController = viewController;
    self.usePersonalizedAds = usePersonalizedAds;
    
    if (self.gadView.superview) {
        [self loadAdMobBanner:self.currentRootViewController.view];
    }
}

// バナー削除
- (void)removeAdBanner
{
    if (self.gadView.superview) {
        [self.gadView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.gadView.superview) {
        self.gadView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.gadView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.gadView atIndex:subviewsCount + 1];
    }
}

#pragma mark - AdMob Banner

- (void)showAdMobBanner:(UIView *)targetView
{
    if (!self.gadView) {
        if (self.useAdaptiveBanner) {
            self.gadView = [[GADBannerView alloc] initWithAdSize:GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(targetView.frame.size.width)];
        } else if (self.useSmartBanner) {
            self.gadView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
        } else {
            self.gadView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
        }
        self.gadView.adUnitID = GAD_TEST_MODE ? GAD_TEST_UNIT_ID : GAD_UNIT_ID;
        self.gadView.delegate = self;
        [self loadAdMobBanner:targetView];
    }
    
    if (![self.gadView.superview isEqual:targetView]) {
        [self.gadView removeFromSuperview];
        [self loadAdMobBanner:targetView];
    }
}

- (void)loadAdMobBanner:(UIView *)view
{
    self.gadView.rootViewController = self.currentRootViewController;
    
    CGRect gadViewFrame = self.gadView.frame;
    gadViewFrame.origin = CGPointMake(bannerX, bannerY);
    self.gadView.frame = gadViewFrame;
    [view addSubview:self.gadView];
    
    GADRequest *request = [GADRequest request];
    if (GAD_TEST_MODE) {
        [[GADMobileAds sharedInstance] requestConfiguration].testDeviceIdentifiers = @[kGADSimulatorID,
                                                                                       GAD_TEST_DEVICE1, GAD_TEST_DEVICE2,
                                                                                       GAD_TEST_DEVICE3, GAD_TEST_DEVICE4];
    }
    
    if (!self.usePersonalizedAds) {
        GADExtras *extras = [[GADExtras alloc] init];
        extras.additionalParameters = @{@"npa": @"1"};
        [request registerAdNetworkExtras:extras];
    }
    //NSLog(@"DCAdMobBanner -> usePersonalizedAds: %d", self.usePersonalizedAds);
    
    [self.gadView loadRequest:request];
}

#pragma mark - delegate method

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    BOOL const useFadeInAnimation = self.fadeInDuration > 0.0;
    if (useFadeInAnimation) {
        bannerView.alpha = 0.0;
        [UIView animateWithDuration:self.fadeInDuration animations:^{
            bannerView.alpha = 1.0;
        }];
    }
    
    _loaded = YES;
    
    isAdMobFailed = !_loaded;
}
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
{
    _loaded = NO;
    
    isAdMobFailed = !_loaded;
    
    // バナー再読み込み
    [self showAdBanner:self.currentRootViewController yPos:bannerY fadeInDuration:self.fadeInDuration
     useAdaptiveBanner:self.useAdaptiveBanner useSmartBanner:self.useSmartBanner usePersonalizedAds:self.usePersonalizedAds];
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
