//
//  DCAdMobBanner.h
//
//  Created by Masaki Hirokawa on 2014/02/23.
//  Copyright (c) 2014 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>

<<<<<<< Updated upstream:DCLibrary/DCAdMobBanner.h
=======
<<<<<<< HEAD:DCLibrary/Ad/DCAdMobBanner.h
@import GoogleMobileAds;

=======
>>>>>>> origin/master:DCLibrary/DCAdMobBanner.h
>>>>>>> Stashed changes:DCLibrary/Ad/DCAdMobBanner.h
@interface DCAdMobBanner : NSObject <GADBannerViewDelegate>

#pragma mark - property
@property (nonatomic, strong) GADBannerView    *gadView;
@property (nonatomic, strong) UIViewController *currentRootViewController;
@property (nonatomic, assign) BOOL             loaded;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;

@end
