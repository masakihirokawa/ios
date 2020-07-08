//
//  DCAdfurikunBanner.h
//
//  Created by Dolice on 2020/07/01.
//  Copyright © 2020 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ADFMovieReward/ADFmyBanner.h>

@interface DCAdfurikunBanner : NSObject <ADFmyNativeAdDelegate> {
    CGFloat bannerY;
    BOOL    isAdfurikunFailed;
}

#pragma mark - property
@property (nonatomic) ADFmyBanner              *bannerAd;
@property (nonatomic) ADFNativeAdInfo          *bannerAdInfo;
@property (nonatomic, strong) UIViewController *currentRootViewController;
@property (nonatomic, assign) NSTimer          *refreshTimer;
@property (nonatomic, assign) BOOL             loaded;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;
- (void)reloadAdBanner;

@end
