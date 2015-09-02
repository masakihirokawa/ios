//
//  DCiAdAdStirBanner.h
//
//  Created by Dolice on 2015/09/02.
//  Copyright © 2015 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>
#import <AdstirAds/AdstirAds.h>

@interface DCiAdAdStirBanner : NSObject <ADBannerViewDelegate, AdstirMraidViewDelegate> {
    CGFloat bannerY;
    BOOL    isiAdFailed;
    BOOL    isAdStirFailed;
}

#pragma mark - property
@property (nonatomic, strong) ADBannerView     *iAdView;
@property (nonatomic, retain) AdstirMraidView  *adStirView;
@property (nonatomic, strong) UIViewController *currentRootViewController;
@property (nonatomic, assign) BOOL             loaded;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;

@end
