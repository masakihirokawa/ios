//
//  DCiAdAdStirBanner.m
//
//  Created by Dolice on 2015/09/02.
//  Copyright © 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCiAdAdStirBanner.h"

@implementation DCiAdAdStirBanner

@synthesize iAdView                   = _iAdView;
@synthesize adStirView                = _adStirView;
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
            // AdStir
            [self showAdStirBanner:viewController.view];
        } else if (isAdStirFailed) {
            // iAd
            [self showiAdBanner:viewController.view];
        } else {
            // iAd
            [self showiAdBanner:viewController.view];
        }
    } else if (isiAdFailed) {
        // iAdの取得に失敗した場合は AdStirに切り替える
        [self showAdStirBanner:viewController.view];
    } else if (isAdStirFailed) {
        // AdStirの取得に失敗した場合は iAdに切り替える
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
    
    if (self.adStirView.superview) {
        [self.adStirView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.iAdView.superview) {
        self.iAdView.hidden = hidden;
    }
    
    if (self.adStirView.superview) {
        self.adStirView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.iAdView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.iAdView atIndex:subviewsCount + 1];
    }
    
    if (self.adStirView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.adStirView atIndex:subviewsCount + 1];
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

#pragma mark - AdStir Banner

- (void)showAdStirBanner:(UIView *)targetView
{
    [self removeAdBanner];
    
    CGFloat const screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat const bannerX     = roundf((screenWidth / 2) - (kAdstirAdSize320x50.size.width / 2));
    
    self.adStirView = [[AdstirMraidView alloc] initWithAdSize:kAdstirAdSize320x50 origin:CGPointMake(bannerX, bannerY)
                                                        media:ADSTIR_MEDIA_ID spot:ADSTIR_SPOT_ID];
    self.adStirView.delegate = self;
    self.adStirView.intervalTime = 30;
    [targetView addSubview:self.adStirView];
    
    [self.adStirView start];
    
    _loaded = YES;
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

#pragma mark - AdStir delegate method

- (void)adstirMraidViewWillPresentScreen:(AdstirMraidView *)mraidView
{
    NSLog(@"adstirMraidViewWillPresentScreen");
}

- (void)adstirMraidViewDidPresentScreen:(AdstirMraidView *)mraidView
{
    NSLog(@"adstirMraidViewDidPresentScreen");
    
    _loaded = YES;
    
    isAdStirFailed = !_loaded;
}

- (void)adstirMraidViewWillDismissScreen:(AdstirMraidView *)mraidView
{
    NSLog(@"adstirMraidViewWillDismissScreen");
}

- (void)adstirMraidViewWillLeaveApplication:(AdstirMraidView *)mraidView
{
    NSLog(@"adstirMraidViewWillLeaveApplication");
    
    _loaded = NO;
    
    isAdStirFailed = !_loaded;
    
    // バナー再読み込み
    [self showAdBanner:self.currentRootViewController yPos:bannerY];
}

@end
