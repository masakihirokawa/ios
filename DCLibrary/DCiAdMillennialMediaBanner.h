//
//  DCiAdMillennialMediaBanner.h
//
//  Created by Dolice on 2015/09/09.
//  Copyright © 2015 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>
#import <MMAdSDK/MMAdSDK.h>

@interface DCiAdMillennialMediaBanner : NSObject <ADBannerViewDelegate, MMInlineDelegate> {
    CGFloat bannerY;
    BOOL    isiAdFailed;
    BOOL    isMillennialMediaFailed;
}

#pragma mark - property
@property (nonatomic, strong) ADBannerView     *iAdView;
@property (nonatomic, retain) MMInlineAd       *millennialMediaAd;
@property (nonatomic, strong) UIViewController *currentRootViewController;
@property (nonatomic, assign) BOOL             loaded;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;

@end
