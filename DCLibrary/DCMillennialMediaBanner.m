//
//  DCMillennialMediaBanner.m
//
//  Created by Dolice on 2015/09/09.
//  Copyright © 2015 Masaki Hirokawa. All rights reserved.
//

#import "DCMillennialMediaBanner.h"

@implementation DCMillennialMediaBanner

@synthesize millennialMediaAd         = _millennialMediaAd;
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
    
    CGFloat const screenWidth  = [[UIScreen mainScreen] bounds].size.width;
    CGFloat const bannerWidth  = 320;
    CGFloat const bannerHeight = 50;
    CGFloat const bannerX      = roundf((screenWidth / 2) - (bannerWidth / 2));
    
    self.millennialMediaAd = [[MMInlineAd alloc] initWithPlacementId:MMEDIA_APID
                                                              adSize:MMInlineAdSizeBanner];
    [self.millennialMediaAd.view setFrame:CGRectMake(bannerX, bannerY, bannerWidth, bannerHeight)];
    self.millennialMediaAd.delegate = self;
    [viewController.view addSubview:self.millennialMediaAd.view];
    [self.millennialMediaAd request:nil];
}

// バナー削除
- (void)removeAdBanner
{
    if (self.millennialMediaAd.view.superview) {
        [self.millennialMediaAd.view removeFromSuperview];
    }
}

// バナー非表示
- (void)hideAdBanner:(BOOL)hidden
{
    if (self.millennialMediaAd.view.superview) {
        self.millennialMediaAd.view.hidden = hidden;
    }
}

// バナーを最前面に配置
- (void)insertAdBanner
{
    if (self.millennialMediaAd.view.superview) {
        NSUInteger subviewsCount = [[self.currentRootViewController.view subviews] count];
        [self.currentRootViewController.view insertSubview:self.millennialMediaAd.view atIndex:subviewsCount + 1];
    }
}

#pragma mark - delegate method

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

@end
