//
//  DCAdMobAdGenerationBanner.m
//
//  Created by Dolice on 2015/09/30.
//  Copyright (c) 2015 Dolice. All rights reserved.
//

#import "DCAdMobAdGenerationBanner.h"

@implementation DCAdMobAdGenerationBanner

@synthesize gadView                   = _gadView;
@synthesize adGenerationView          = _adGenerationView;
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
            // Ad Generation
            [self showAdGenerationBanner:viewController.view];
        } else if (isAdGenerationFailed) {
            // AdMob
            [self showAdMobBanner:viewController.view];
        } else {
            // AdMob
            [self showAdMobBanner:viewController.view];
        }
    } else if (isAdMobFailed) {
        // AdMobの取得に失敗した場合は Ad Generationに切り替える
        [self showAdGenerationBanner:viewController.view];
    } else if (isAdGenerationFailed) {
        // Ad Generationの取得に失敗した場合は AdMobに切り替える
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
    
    if (self.adGenerationView.view.superview) {
        [self.adGenerationView.view removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.gadView.superview) {
        self.gadView.hidden = hidden;
    }
    
    if (self.adGenerationView.view.superview) {
        self.adGenerationView.view.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.gadView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.gadView atIndex:subviewsCount + 1];
    }
    
    if (self.adGenerationView.view.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.adGenerationView.view atIndex:subviewsCount + 1];
    }
}

#pragma mark - AdMob Banner

- (void)showAdMobBanner:(UIView *)targetView
{
    if (!self.gadView) {
        self.gadView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthPortraitWithHeight(GAD_SIZE_320x50.height)];
        self.gadView.adUnitID = GAD_UNIT_ID;
        self.gadView.delegate = self;
        [self loadAdMobBanner:targetView yPos:bannerY];
    }
    
    if (self.adGenerationView.view.superview) {
        [self.adGenerationView.view removeFromSuperview];
    }
    
    if (![self.gadView.superview isEqual:targetView]) {
        [self.gadView removeFromSuperview];
        [self loadAdMobBanner:targetView yPos:bannerY];
    }
}

- (void)loadAdMobBanner:(UIView *)view yPos:(CGFloat)yPos
{
    self.gadView.rootViewController = self.currentRootViewController;
    
    CGRect gadViewFrame = self.gadView.frame;
    gadViewFrame.origin = CGPointMake(0, yPos);
    self.gadView.frame = gadViewFrame;
    
    [view addSubview:self.gadView];
    [self.gadView loadRequest:[GADRequest request]];
}

#pragma mark - Ad Generation Banner

- (void)showAdGenerationBanner:(UIView *)targetView
{
    [self removeAdBanner];
    
    CGFloat const screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat const bannerX     = roundf((screenWidth / 2) - (kADGAdSize_Sp_Width / 2));
    
    NSDictionary *adGenerationParams = @{@"locationid" : AD_GENERATION_APPID,
                                         @"adtype" : @(kADG_AdType_Sp),
                                         @"originx" : @(bannerX),
                                         @"originy" : @(bannerY),
                                         @"w" : @(0),
                                         @"h" : @(0)};
    
    self.adGenerationView = [[ADGManagerViewController alloc] initWithAdParams:adGenerationParams
                                                                        adView:targetView];
    self.adGenerationView.delegate = self;
    [self.adGenerationView setPreLoad:YES];
    [self.adGenerationView setFillerRetry:NO];
    [self.adGenerationView loadRequest];
    [self.adGenerationView resumeRefresh];
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

#pragma mark - Ad Generation delegate method

- (void)ADGManagerViewControllerReceiveAd:(ADGManagerViewController *)adgManagerViewController
{
    //NSLog(@"%@", @"ADGManagerViewControllerReceiveAd");
    
    _loaded = YES;
    
    isAdGenerationFailed = !_loaded;
}

- (void)ADGManagerViewControllerFailedToReceiveAd:(ADGManagerViewController *)adgManagerViewController code:(kADGErrorCode)code
{
    //NSLog(@"%@", @"ADGManagerViewControllerFailedToReceiveAd");
    
    _loaded = NO;
    
    isAdGenerationFailed = !_loaded;
    
    switch (code) {
        case kADGErrorCodeExceedLimit:
        case kADGErrorCodeNeedConnection:
            break;
        default:
            // バナー再読み込み
            [self showAdBanner:self.currentRootViewController yPos:bannerY];
            //[self.adGenerationView loadRequest];
            
            break;
    }
}

- (void)ADGManagerViewControllerOpenUrl:(ADGManagerViewController *)adgManagerViewController
{
    //NSLog(@"%@", @"ADGManagerViewControllerOpenUrl");
}

@end
