//
//  DCMillennialMediaAdfurikunBanner.m
//
//  Created by Dolice on 2015/09/10.
//  Copyright © 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCMillennialMediaAdfurikunBanner.h"

@implementation DCMillennialMediaAdfurikunBanner

@synthesize millennialMediaAd         = _millennialMediaAd;
@synthesize adfurikunView             = _adfurikunView;
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
        if (isMillennialMediaFailed) {
            // Adfurikun
            [self showAdfurikunBanner:viewController.view];
        } else if (isAdfurikunFailed) {
            // Millennial Media
            [self showMillennialMediaBanner:viewController.view];
        } else {
            // Millennial Media
            [self showMillennialMediaBanner:viewController.view];
        }
    } else if (isMillennialMediaFailed) {
        // Millennial Mediaの取得に失敗した場合は Adfurikunに切り替える
        [self showAdfurikunBanner:viewController.view];
    } else if (isAdfurikunFailed) {
        // Adfurikunの取得に失敗した場合は Millennial Mediaに切り替える
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
    
    if (self.adfurikunView.superview) {
        [self.adfurikunView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.millennialMediaAd.view.superview) {
        self.millennialMediaAd.view.hidden = hidden;
    }
    
    if (self.adfurikunView.superview) {
        self.adfurikunView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.millennialMediaAd.view.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.millennialMediaAd.view atIndex:subviewsCount + 1];
    }
    
    if (self.adfurikunView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.adfurikunView atIndex:subviewsCount + 1];
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

@end
