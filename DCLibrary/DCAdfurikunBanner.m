//
//  DCAdfurikunBanner.m
//
//  Created by Dolice on 2015/09/02.
//  Copyright © 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCAdfurikunBanner.h"

@implementation DCAdfurikunBanner

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
    [self removeAdBanner];
    
    if (![viewController isEqual:self.currentRootViewController]) {
        self.currentRootViewController = viewController;
    }
    
    bannerY = yPos;
    
    CGFloat const screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat const bannerX     = roundf((screenWidth / 2) - (ADFRJS_VIEW_SIZE_320x50.width / 2));
    
    self.adfurikunView = [[AdfurikunView alloc] initWithFrame:CGRectMake(bannerX, bannerY,
                                                                         ADFRJS_VIEW_SIZE_320x50.width, ADFRJS_VIEW_SIZE_320x50.height)];
    self.adfurikunView.delegate = self;
    self.adfurikunView.appId = ADFURIKUN_APPID;
    self.adfurikunView.transitionDulation = 0.5f;
    [viewController.view addSubview:self.adfurikunView];
    
    [self.adfurikunView.layer setBorderColor:[UIColor clearColor].CGColor];
    [self.adfurikunView.layer setBorderWidth:1.0];
    
    //[self.adfurikunView testModeEnable];
    [self.adfurikunView startShowAd];
}

// バナー削除
- (void)removeAdBanner
{
    if (self.adfurikunView.superview) {
        [self.adfurikunView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.adfurikunView.superview) {
        self.adfurikunView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.adfurikunView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.adfurikunView atIndex:subviewsCount + 1];
    }
}

#pragma mark - delegate method

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
