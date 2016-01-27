//
//  DCAdGenerationBanner.h
//
//  Created by Dolice on 2015/09/08.
//  Copyright © 2015 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ADG/ADGManagerViewController.h>

@interface DCAdGenerationBanner : NSObject <ADGManagerViewControllerDelegate> {
    CGFloat bannerY;
    BOOL    isAdGenerationFailed;
}

#pragma mark - property
@property (nonatomic, retain) ADGManagerViewController *adGenerationView;
@property (nonatomic, strong) UIViewController         *currentRootViewController;
@property (nonatomic, assign) BOOL                     loaded;

#pragma mark - public method
+ (id)sharedManager;
- (void)showAdBanner:(UIViewController *)viewController yPos:(CGFloat)yPos;
- (void)removeAdBanner;
- (void)hideAdBanner:(BOOL)hidden;
- (void)insertAdBanner;

@end
