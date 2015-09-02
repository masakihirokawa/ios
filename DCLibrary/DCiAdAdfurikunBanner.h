//
//  DCiAdAdfurikunBanner.h
//
//  Created by Dolice on 2015/09/02.
//  Copyright © 2015 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>
#import <adfurikunsdk/AdfurikunView.h>

@interface DCiAdAdfurikunBanner : NSObject <ADBannerViewDelegate, AdfurikunViewDelegate> {
    CGFloat bannerY;
    BOOL    isiAdFailed;
    BOOL    isAdfurikunFailed;
}

#pragma mark - property
@property (nonatomic, strong) ADBannerView     *iAdView;
@property (nonatomic, retain) AdfurikunView    *adfurikunView;
@property (nonatomic, strong) UIViewController *currentRootViewController;
@property (nonatomic, assign) BOOL             loaded;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;

@end
