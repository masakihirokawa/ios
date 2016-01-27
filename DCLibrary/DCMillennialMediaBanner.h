//
//  DCMillennialMediaBanner.h
//
//  Created by Dolice on 2015/09/09.
//  Copyright © 2015 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MMAdSDK/MMAdSDK.h>

@interface DCMillennialMediaBanner : NSObject <MMInlineDelegate> {
    CGFloat bannerY;
    BOOL    isMillennialMediaFailed;
}

#pragma mark - property
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
