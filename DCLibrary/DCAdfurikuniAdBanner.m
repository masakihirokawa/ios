//
//  DCAdfurikuniAdBanner.m
//
//  Created by Dolice on 2015/09/02.
//  Copyright © 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCAdfurikuniAdBanner.h"

@implementation DCAdfurikuniAdBanner

@synthesize adfurikunView             = _adfurikunView;
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
        if (isAdfurikunFailed) {
            // iAd
            [self showiAdBanner:viewController.view];
        } else if (isiAdFailed) {
            // Adfurikun
            [self showAdfurikunBanner:viewController.view];
        } else {
            // Adfurikun
            [self showAdfurikunBanner:viewController.view];
        }
    } else if (isAdfurikunFailed) {
        // Adfurikunの取得に失敗した場合は iAdに切り替える
        [self showiAdBanner:viewController.view];
    } else if (isiAdFailed) {
        // iAdの取得に失敗した場合は Adfurikunに切り替える
        [self showAdfurikunBanner:viewController.view];
    } else {
        // Adfurikun
        [self showAdfurikunBanner:viewController.view];
    }
}

// バナー削除
- (void)removeAdBanner
{
    if (self.adfurikunView.superview) {
        [self.adfurikunView removeFromSuperview];
    }
    
    if (self.iAdView.superview) {
        [self.iAdView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.adfurikunView.superview) {
        self.adfurikunView.hidden = hidden;
    }
    
    if (self.iAdView.superview) {
        self.iAdView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.adfurikunView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.adfurikunView atIndex:subviewsCount + 1];
    }
    
    if (self.iAdView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.iAdView atIndex:subviewsCount + 1];
    }
}

#pragma mark - Adfurikun Banner

- (void)showAdfurikunBanner:(UIView *)targetView
{
    [self removeAdBanner];
    
    CGFloat const screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat const bannerX     = roundf((screenWidth / 2) - (ADFRJS_VIEW_SIZE_320x50.width / 2));
    
    self.adfurikunView = [[AdfurikunView alloc] initWithFrame:CGRectMake(bannerX, bannerY,
                                                                         ADFRJS_VIEW_SIZE_320x50.width, ADFRJS_VIEW_SIZE_320x50.height)];
    self.adfurikunView.delegate = self;
    self.adfurikunView.appId = ADFURIKUN_APPID;
    self.adfurikunView.transitionDulation = 0.5f;
    [targetView addSubview:self.adfurikunView];
    
    [self.adfurikunView.layer setBorderColor:[UIColor clearColor].CGColor];
    [self.adfurikunView.layer setBorderWidth:1.0];
    
    //[self.adfurikunView testModeEnable];
    [self.adfurikunView startShowAd];
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

#pragma mark - Adfurikun delegate method

- (void)adfurikunViewDidFinishLoad:(AdfurikunView *)view
{
    //NSLog(@"adfurikunViewDidFinishLoad");
    
    _loaded = YES;
    
    isAdfurikunFailed = !_loaded;
}

- (void)adfurikunViewAdTapped:(AdfurikunView *)view
{
    //NSLog(@"adfurikunViewAdTapped");
}

- (void)adfurikunViewAdFailed:(AdfurikunView *)view
{
    //NSLog(@"adfurikunViewAdFailed");
    
    _loaded = NO;
    
    isAdfurikunFailed = !_loaded;
    
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
