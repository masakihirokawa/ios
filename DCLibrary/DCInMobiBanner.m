//
//  DCInMobiBanner.m
//
//  Created by Dolice on 2015/05/22.
//  Copyright (c) 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCInMobiBanner.h"

@implementation DCInMobiBanner

@synthesize inMobiView                = _inMobiView;
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
    
    self.inMobiView = [[IMBanner alloc] initWithFrame:CGRectMake(bannerX, bannerY, BANNER_WIDTH, BANNER_HEIGHT)
                                                placementId:INMOBI_PLACEMENT_ID];
    self.inMobiView.delegate = self;
    self.inMobiView.transitionAnimation = UIViewAnimationTransitionNone;
    [viewController.view addSubview:self.inMobiView];
    
    [self.inMobiView load];
}

// バナー削除
- (void)removeAdBanner
{
    if (self.inMobiView.superview) {
        [self.inMobiView removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.inMobiView.superview) {
        self.inMobiView.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.inMobiView.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.inMobiView atIndex:subviewsCount + 1];
    }
}

#pragma mark - delegate method

- (void)bannerDidFinishLoading:(IMBanner *)banner
{
    _loaded = YES;
    
    isInMobiFailed = !_loaded;
}

- (void)banner:(IMBanner *)banner didFailToLoadWithError:(IMRequestStatus *)error
{
    _loaded = NO;
    
    isInMobiFailed = !_loaded;
    
    // バナー再読み込み
    [self showAdBanner:self.currentRootViewController yPos:bannerY];
}

- (void)banner:(IMBanner *)banner didInteractWithParams:(NSDictionary *)params
{
}

- (void)userWillLeaveApplicationFromBanner:(IMBanner *)banner
{
}

- (void)bannerWillPresentScreen:(IMBanner *)banner
{
}

- (void)bannerDidPresentScreen:(IMBanner *)banner
{
}

- (void)bannerWillDismissScreen:(IMBanner *)banner
{
}

- (void)bannerDidDismissScreen:(IMBanner *)banner
{
}

- (void)banner:(IMBanner *)banner rewardActionCompletedWithRewards:(NSDictionary *)rewards
{
}

@end
