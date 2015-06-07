//
//  DCNendiAdBanner.h
//
//  Created by Dolice on 2015/05/20.
//  Copyright (c) 2015 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NADView.h"

@interface DCNendiAdBanner : NSObject <NADViewDelegate, ADBannerViewDelegate> {
    CGFloat bannerY;
    BOOL    isNendFailed;
    BOOL    isiAdFailed;
}

#pragma mark - property
@property (nonatomic, strong) NADView          *nendView;
@property (nonatomic, strong) ADBannerView     *iAdView;
@property (nonatomic, strong) UIViewController *currentRootViewController;
@property (nonatomic, assign) BOOL             loaded;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;

@end
