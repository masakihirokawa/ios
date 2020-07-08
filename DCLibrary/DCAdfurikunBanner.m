//
//  DCAdfurikunBanner.m
//
//  Created by Dolice on 2020/07/01.
//  Copyright © 2020 Masaki Hirokawa. All rights reserved.
//

#import "DCAdfurikunBanner.h"

@implementation DCAdfurikunBanner

@synthesize bannerAd                  = _bannerAd;
@synthesize bannerAdInfo              = _bannerAdInfo;
@synthesize currentRootViewController = _currentRootViewController;
@synthesize refreshTimer              = _refreshTimer;
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

// バナー表示
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos
{
    [self removeAdBanner];
    
    if (![viewController isEqual:self.currentRootViewController]) {
        self.currentRootViewController = viewController;
    }
    
    bannerY = yPos;
    
    _bannerAd = [ADFmyBanner createInstance:ADFURIKUN_AD_UNIT_ID];
    [_bannerAd loadAndNotifyTo:self];
}

// バナー削除
- (void)removeAdBanner
{
    if (_bannerAdInfo) {
        [_bannerAdInfo.mediaView removeFromSuperview];
        _bannerAdInfo.mediaView = nil;
        _bannerAdInfo = nil;
    }
    
    [self clearRefreshTimer];
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (_bannerAdInfo) {
        _bannerAdInfo.mediaView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (_bannerAdInfo) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:_bannerAdInfo.mediaView atIndex:subviewsCount + 1];
    }
}

// バナーの再読み込み
- (void)reloadAdBanner {
    if (_bannerAdInfo) {
        [self removeAdBanner];
        [_bannerAd loadAndNotifyTo:self];
    }
}

#pragma mark - Refresh Timer

// 広告の自動更新タイマー開始
- (void)startRefreshTimer
{
    _refreshTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self reloadAdBanner];
    }];
}

// 広告の自動更新タイマー削除
- (void)clearRefreshTimer
{
    if (_refreshTimer != nil) {
        [_refreshTimer invalidate];
        _refreshTimer = nil;
    }
}

#pragma mark - delegate method

// バナーの取得に成功した時に呼ばれる
- (void)onNativeAdLoadFinish:(ADFNativeAdInfo *)info appID:(NSString *)appID
{
    //NSLog(@"onNativeAdLoadFinish");
    
    _bannerAdInfo = info;
    
    CGFloat const bannerWidth  = self.currentRootViewController.view.frame.size.width;
    CGFloat const bannerHeight = 50.0;
    
    _bannerAdInfo.mediaView.frame = CGRectMake(0.0, bannerY, bannerWidth, bannerHeight);
    [self.currentRootViewController.view addSubview:_bannerAdInfo.mediaView];
    [_bannerAdInfo playMediaView];
    
    [self clearRefreshTimer];
    [self startRefreshTimer];
    
    _loaded = YES;
    
    isAdfurikunFailed = !_loaded;
}

// バナーの取得に失敗した時に呼ばれる
- (void)onNativeAdLoadError:(ADFMovieError *)error appID:(NSString *)appID
{
    //NSLog(@"Failed to load native ad, error code=%lu, error message=\"%@\"", (unsigned long)error.errorCode, error.errorMessage);
    
    _loaded = NO;
    
    isAdfurikunFailed = !_loaded;
    
    // バナー再読み込み
    [self showAdBanner:self.currentRootViewController yPos:bannerY];
}

@end
