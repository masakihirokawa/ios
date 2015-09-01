//
//  DCAdStirBanner.m
//
//  Created by Dolice on 2015/09/01.
//  Copyright (c) 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCAdStirBanner.h"

@implementation DCAdStirBanner

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
    CGFloat const bannerX     = roundf((screenWidth / 2) - (kAdstirAdSize320x50.size.width / 2));
    
    _adStirView = [[AdstirMraidView alloc] initWithAdSize:kAdstirAdSize320x50 origin:CGPointMake(bannerX, bannerY)
                                                    media:ADSTIR_MEDIA_ID spot:ADSTIR_SPOT_ID];
    _adStirView.delegate = self;
    _adStirView.intervalTime = 30;
    [viewController.view addSubview:_adStirView];
    
    [_adStirView start];
    
    _loaded = YES;
}

// バナー削除
- (void)removeAdBanner
{
    if (self.adStirView.superview) {
        [self.adStirView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.adStirView.superview) {
        self.adStirView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.adStirView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.adStirView atIndex:subviewsCount + 1];
    }
}

#pragma mark - delegate method

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
