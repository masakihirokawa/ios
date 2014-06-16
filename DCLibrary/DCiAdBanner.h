//
//  DCiAdBanner.h
//  DoliceGraphicArtsWallpaper
//
//  Created by Dolice on 2014/06/16.
//  Copyright (c) 2014年 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>

@interface DCiAdBanner : NSObject <ADBannerViewDelegate> {
    BOOL isiAdFailed;
}

#pragma mark - property
@property (nonatomic, strong) ADBannerView     *iAdView;
@property (nonatomic, strong) UIViewController *currentRootViewController;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos;
- (void)removeAdBanner;

@end
