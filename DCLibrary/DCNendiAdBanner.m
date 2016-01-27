//
//  DCNendiAdBanner.m
//
//  Created by Dolice on 2015/05/20.
//  Copyright (c) 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCNendiAdBanner.h"

@implementation DCNendiAdBanner

@synthesize nendView                  = _nendView;
@synthesize iAdView                   = _iAdView;
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
        if (isNendFailed) {
            // iAd
            [self showiAdBanner:viewController.view];
        } else if (isiAdFailed) {
            // Nend
            [self showNendBanner:viewController.view];
        } else {
            // Nend
            [self showNendBanner:viewController.view];
        }
    } else if (isNendFailed) {
        // Nendの取得に失敗した場合は iAdに切り替える
        [self showiAdBanner:viewController.view];
    } else if (isiAdFailed) {
        // iAdの取得に失敗した場合は Nendに切り替える
        [self showNendBanner:viewController.view];
    } else {
        // Nend
        [self showNendBanner:viewController.view];
    }
}

// バナー削除
- (void)removeAdBanner
{
    if (self.nendView.superview) {
        [self.nendView removeFromSuperview];
    }
    
    if (self.iAdView.superview) {
        [self.iAdView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.nendView.superview) {
        self.nendView.hidden = hidden;
    }
    
    if (self.iAdView.superview) {
        self.iAdView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.nendView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.nendView atIndex:subviewsCount + 1];
    }
    
    if (self.iAdView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.iAdView atIndex:subviewsCount + 1];
    }
}

#pragma mark - Nend Banner

- (void)showNendBanner:(UIView *)targetView
{
    [self removeAdBanner];
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat bannerX     = roundf((screenWidth / 2) - (NAD_ADVIEW_SIZE_320x50.width / 2));
    
    self.nendView = [[NADView alloc] initWithFrame:CGRectMake(bannerX, bannerY,
                                                              NAD_ADVIEW_SIZE_320x50.width, NAD_ADVIEW_SIZE_320x50.height)];
    self.nendView.isOutputLog = NO;
    self.nendView.nendApiKey = NEND_API_KEY;
    self.nendView.nendSpotID = NEND_SPOT_ID;
    self.nendView.delegate = self;
    [targetView addSubview:self.nendView];
    
    [self.nendView load];
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

@end
