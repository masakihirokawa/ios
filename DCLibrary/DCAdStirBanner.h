//
//  DCAdStirBanner.h
//
//  Created by Dolice on 2015/09/01.
//  Copyright (c) 2015 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AdstirAds/AdstirAds.h>

@interface DCAdStirBanner : NSObject <AdstirMraidViewDelegate> {
    CGFloat bannerY;
    BOOL    isAdStirFailed;
}

#pragma mark - property
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
