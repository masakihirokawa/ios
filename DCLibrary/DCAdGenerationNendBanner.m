//
//  DCAdGenerationNendBanner.m
//
//  Created by Dolice on 2016/01/27.
//  Copyright © 2016 Masaki Hirokawa. All rights reserved.
//

#import "DCAdGenerationNendBanner.h"

@implementation DCAdGenerationNendBanner

@synthesize adGenerationView          = _adGenerationView;
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
        if (isAdGenerationFailed) {
            // Nend
            [self showNendBanner:viewController.view];
        } else if (isNendFailed) {
            // Ad Generation
            [self showAdGenerationBanner:viewController.view];
        } else {
            // Ad Generation
            [self showAdGenerationBanner:viewController.view];
        }
    } else if (isAdGenerationFailed) {
        // Ad Generationの取得に失敗した場合は Nendに切り替える
        [self showNendBanner:viewController.view];
    } else if (isNendFailed) {
        // Nendの取得に失敗した場合は Ad Generationに切り替える
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
    
    if (self.nendView.superview) {
        [self.nendView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.adGenerationView.view.superview) {
        self.adGenerationView.view.hidden = hidden;
    }
    
    if (self.nendView.superview) {
        self.nendView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.adGenerationView.view.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.adGenerationView.view atIndex:subviewsCount + 1];
    }
    
    if (self.nendView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.nendView atIndex:subviewsCount + 1];
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

#pragma mark - Nend Banner

- (void)showNendBanner:(UIView *)targetView
{
    [self removeAdBanner];
    
    CGFloat const screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat const bannerX     = roundf((screenWidth / 2) - (NAD_ADVIEW_SIZE_320x50.width / 2));
    
    self.nendView = [[NADView alloc] initWithFrame:CGRectMake(bannerX, bannerY,
                                                              NAD_ADVIEW_SIZE_320x50.width, NAD_ADVIEW_SIZE_320x50.height)];
    self.nendView.isOutputLog = NO;
    self.nendView.nendApiKey = NEND_API_KEY;
    self.nendView.nendSpotID = NEND_SPOT_ID;
    self.nendView.delegate = self;
    [targetView addSubview:self.nendView];
    
    [self.nendView load];
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
