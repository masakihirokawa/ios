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
    
    CGFloat const BANNER_WIDTH  = 320;
    CGFloat const BANNER_HEIGHT = 50;
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat bannerX     = roundf((screenWidth / 2) - (BANNER_WIDTH / 2));
    
    self.nendView = [[NADView alloc] initWithFrame:CGRectMake(bannerX, bannerY, BANNER_WIDTH, BANNER_HEIGHT)];
    self.nendView.isOutputLog = NO;
    self.nendView.nendApiKey = NEND_API_KEY;
    self.nendView.nendSpotID = NEND_SPOT_ID;
    self.nendView.delegate = self;
    [viewController.view addSubview:self.nendView];
    
    [self.nendView load];
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
