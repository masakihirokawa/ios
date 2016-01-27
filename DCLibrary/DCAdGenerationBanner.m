//
//  DCAdGenerationBanner.m
//
//  Created by Dolice on 2015/09/08.
//  Copyright © 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCAdGenerationBanner.h"

@implementation DCAdGenerationBanner

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
    [self removeAdBanner];
    
    if (![viewController isEqual:self.currentRootViewController]) {
        self.currentRootViewController = viewController;
    }
    
    bannerY = yPos;
    
    CGFloat const screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat const bannerX     = roundf((screenWidth / 2) - (kADGAdSize_Sp_Width / 2));
    
    NSDictionary *adGenerationParams = @{@"locationid" : AD_GENERATION_APPID,
                                         @"adtype" : @(kADG_AdType_Sp),
                                         @"originx" : @(bannerX),
                                         @"originy" : @(bannerY),
                                         @"w" : @(0),
                                         @"h" : @(0)};
    
    self.adGenerationView = [[ADGManagerViewController alloc] initWithAdParams:adGenerationParams
                                                                        adView:viewController.view];
    self.adGenerationView.delegate = self;
    //[self.adGenerationView setPreLoad:YES];
    [self.adGenerationView setFillerRetry:NO];
    [self.adGenerationView loadRequest];
    [self.adGenerationView resumeRefresh];
}

// バナー削除
- (void)removeAdBanner
{
    if (self.adGenerationView.view.superview) {
        [self.adGenerationView.view removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.adGenerationView.view.superview) {
        self.adGenerationView.view.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.adGenerationView.view.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.adGenerationView.view atIndex:subviewsCount + 1];
    }
}

#pragma mark - delegate method

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
            //[self showAdBanner:self.currentRootViewController yPos:bannerY];
            [self.adGenerationView loadRequest];
            
            break;
    }
}

- (void)ADGManagerViewControllerOpenUrl:(ADGManagerViewController *)adgManagerViewController
{
    //NSLog(@"%@", @"ADGManagerViewControllerOpenUrl");
}

@end
