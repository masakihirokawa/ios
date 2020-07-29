//
//  DCNendBanner.m
//
//  Created by Dolice on 2015/05/22.
//  Copyright (c) 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCNendBanner.h"

@implementation DCNendBanner

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
    [self removeAdBanner];
    
    if (![viewController isEqual:self.currentRootViewController]) {
        self.currentRootViewController = viewController;
    }
    
    bannerY = yPos;
    
    CGFloat const screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat const bannerX     = roundf((screenWidth / 2) - (NAD_ADVIEW_SIZE_320x50.width / 2));
    
    self.nendView = [[NADView alloc] initWithFrame:CGRectMake(bannerX, bannerY,
                                                              NAD_ADVIEW_SIZE_320x50.width, NAD_ADVIEW_SIZE_320x50.height)];
    [self.nendView setNendID:NEND_SPOT_ID apiKey:NEND_API_KEY];
    [self.nendView setDelegate:self];
    [self.nendView load];
    [viewController.view addSubview:self.nendView];
}

// バナー削除
- (void)removeAdBanner
{
    if (self.nendView.superview) {
        [self.nendView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.nendView.superview) {
        self.nendView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.nendView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.nendView atIndex:subviewsCount + 1];
    }
}

#pragma mark - delegate method

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
