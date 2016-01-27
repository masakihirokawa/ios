//
//  DCMillennialMediaiAdBanner.m
//
//  Created by Dolice on 2015/09/09.
//  Copyright © 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCMillennialMediaiAdBanner.h"

@implementation DCMillennialMediaiAdBanner

@synthesize millennialMediaAd         = _millennialMediaAd;
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
        if (isMillennialMediaFailed) {
            // iAd
            [self showiAdBanner:viewController.view];
        } else if (isiAdFailed) {
            // Millennial Media
            [self showMillennialMediaBanner:viewController.view];
        } else {
            // Millennial Media
            [self showMillennialMediaBanner:viewController.view];
        }
    } else if (isMillennialMediaFailed) {
        // Millennial Mediaの取得に失敗した場合は iAdに切り替える
        [self showiAdBanner:viewController.view];
    } else if (isiAdFailed) {
        // iAdの取得に失敗した場合は Millennial Mediaに切り替える
        [self showMillennialMediaBanner:viewController.view];
    } else {
        // Millennial Media
        [self showMillennialMediaBanner:viewController.view];
    }
}

// バナー削除
- (void)removeAdBanner
{
    if (self.millennialMediaAd.view.superview) {
        [self.millennialMediaAd.view removeFromSuperview];
    }
    
    if (self.iAdView.superview) {
        [self.iAdView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.millennialMediaAd.view.superview) {
        self.millennialMediaAd.view.hidden = hidden;
    }
    
    if (self.iAdView.superview) {
        self.iAdView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.millennialMediaAd.view.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.millennialMediaAd.view atIndex:subviewsCount + 1];
    }
    
    if (self.iAdView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.iAdView atIndex:subviewsCount + 1];
    }
}

#pragma mark - Millennial Media Banner

- (void)showMillennialMediaBanner:(UIView *)targetView
{
    [self removeAdBanner];
    
    CGFloat const screenWidth  = [[UIScreen mainScreen] bounds].size.width;
    CGFloat const bannerWidth  = 320;
    CGFloat const bannerHeight = 50;
    CGFloat const bannerX      = roundf((screenWidth / 2) - (bannerWidth / 2));
    
    self.millennialMediaAd = [[MMInlineAd alloc] initWithPlacementId:MMEDIA_APID
                                                              adSize:MMInlineAdSizeBanner];
    [self.millennialMediaAd.view setFrame:CGRectMake(bannerX, bannerY, bannerWidth, bannerHeight)];
    self.millennialMediaAd.delegate = self;
    [targetView addSubview:self.millennialMediaAd.view];
    [self.millennialMediaAd request:nil];
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

#pragma mark - Millennial Media delegate method

- (UIViewController *)viewControllerForPresentingModalView
{
    return self.currentRootViewController;
}

- (void)inlineAdRequestDidSucceed:(MMInlineAd *)ad
{
    //NSLog(@"inlineAdRequestDidSucceed");
    
    _loaded = YES;
    
    isMillennialMediaFailed = !_loaded;
}

- (void)inlineAd:(MMInlineAd *)ad requestDidFailWithError:(NSError*)error
{
    //NSLog(@"requestDidFailWithError");
    
    _loaded = NO;
    
    isMillennialMediaFailed = !_loaded;
    
    // バナー再読み込み
    [self showAdBanner:self.currentRootViewController yPos:bannerY];
}

- (void)inlineAdContentTapped:(MMInlineAd *)ad
{
    
}

- (void)inlineAd:(MMInlineAd *)ad willResizeTo:(CGRect)frame isClosing:(BOOL)isClosingResize
{
    
}

- (void)inlineAd:(MMInlineAd *)ad didResizeTo:(CGRect)frame isClosing:(BOOL)isClosingResize
{
    
}

- (void)inlineAdWillPresentModal:(MMInlineAd *)a
{
    
}

- (void)inlineAdDidPresentModal:(MMInlineAd *)ad
{
    
}

- (void)inlineAdWillCloseModal:(MMInlineAd *)ad
{
    
}

- (void)inlineAdDidCloseModal:(MMInlineAd *)ad
{
    
}

- (void)inlineAdWillLeaveApplication:(MMInlineAd *)ad
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
    [self showAdBanner:self.currentRootViewController yPos:bannerY];
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
}

@end
