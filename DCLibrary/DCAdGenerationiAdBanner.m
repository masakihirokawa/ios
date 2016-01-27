//
//  DCAdGenerationiAdBanner.m
//
//  Created by Dolice on 2015/09/08.
//  Copyright © 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCAdGenerationiAdBanner.h"

@implementation DCAdGenerationiAdBanner

@synthesize adGenerationView          = _adGenerationView;
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
        if (isAdGenerationFailed) {
            // iAd
            [self showiAdBanner:viewController.view];
        } else if (isiAdFailed) {
            // Ad Generation
            [self showAdGenerationBanner:viewController.view];
        } else {
            // Ad Generation
            [self showAdGenerationBanner:viewController.view];
        }
    } else if (isAdGenerationFailed) {
        // Ad Generationの取得に失敗した場合は iAdに切り替える
        [self showiAdBanner:viewController.view];
    } else if (isiAdFailed) {
        // iAdの取得に失敗した場合は Ad Generationに切り替える
        [self showAdGenerationBanner:viewController.view];
    } else {
        // Ad Generation
        [self showAdGenerationBanner:viewController.view];
    }
}

// バナー削除
- (void)removeAdBanner
{
    if (self.adGenerationView.view.superview) {
        [self.adGenerationView.view removeFromSuperview];
    }
    
    if (self.iAdView.superview) {
        [self.iAdView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.adGenerationView.view.superview) {
        self.adGenerationView.view.hidden = hidden;
    }
    
    if (self.iAdView.superview) {
        self.iAdView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.adGenerationView.view.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.adGenerationView.view atIndex:subviewsCount + 1];
    }
    
    if (self.iAdView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.iAdView atIndex:subviewsCount + 1];
    }
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
    //[self.adGenerationView setPreLoad:YES];
    [self.adGenerationView setFillerRetry:NO];
    [self.adGenerationView loadRequest];
    [self.adGenerationView resumeRefresh];
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
