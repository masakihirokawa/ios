//
//  DCAdfurikunInterstitial.h
//
//  Created by Dolice on 2020/07/09.
//

#import <Foundation/Foundation.h>
#import <ADFMovieReward/ADFmyInterstitial.h>

@interface DCAdfurikunInterstitial : NSObject <ADFmyMovieRewardDelegate> {
    ADFmyInterstitial *adfurikunInterstitial;
}

#pragma mark - property
@property (nonatomic, strong) UIViewController *rootViewController;

#pragma mark - public method
+ (id)sharedManager;
- (void)loadInterstitial:(UIViewController *)viewController;

@end
