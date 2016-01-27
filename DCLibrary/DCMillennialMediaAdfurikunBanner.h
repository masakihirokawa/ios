//
//  DCMillennialMediaAdfurikunBanner.h
//
//  Created by Dolice on 2015/09/10.
//  Copyright © 2015 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MMAdSDK/MMAdSDK.h>
#import <adfurikunsdk/AdfurikunView.h>

@interface DCMillennialMediaAdfurikunBanner : NSObject <MMInlineDelegate, AdfurikunViewDelegate> {
    CGFloat bannerY;
    BOOL    isMillennialMediaFailed;
    BOOL    isAdfurikunFailed;
}

#pragma mark - property
@property (nonatomic, retain) MMInlineAd       *millennialMediaAd;
@property (nonatomic, strong) AdfurikunView    *adfurikunView;
@property (nonatomic, strong) UIViewController *currentRootViewController;
@property (nonatomic, assign) BOOL             loaded;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;

@end
