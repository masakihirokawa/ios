//
//  DCAdGenerationNendBanner.h
//
//  Created by Dolice on 2016/01/27.
//  Copyright © 2016 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ADG/ADGManagerViewController.h>
#import "NADView.h"

@interface DCAdGenerationNendBanner : NSObject <ADGManagerViewControllerDelegate, NADViewDelegate> {
    CGFloat bannerY;
    BOOL    isAdGenerationFailed;
    BOOL    isNendFailed;
}

#pragma mark - property
@property (nonatomic, strong) ADGManagerViewController *adGenerationView;
@property (nonatomic, strong) NADView                  *nendView;
@property (nonatomic, strong) UIViewController         *currentRootViewController;
@property (nonatomic, assign) BOOL                     loaded;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;

@end
