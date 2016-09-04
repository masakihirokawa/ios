//
//  DCAdMobNativeAds.m
//
//  Created by Dolice on 2016/08/16.
//  Copyright © 2016 Dolice. All rights reserved.
//

#import "DCAdMobNativeAds.h"

@implementation DCAdMobNativeAds

@synthesize nativeExpressAdView = nativeExpressAdView;

CGFloat const GAD_NATIVE_UNIT_ID = @"Your Unit ID here";
BOOL    const GAD_TEST_MODE      = YES;

#pragma mark - Shared Manager

static id sharedInstance = nil;

+ (id)sharedManager
{
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    }
    
    return sharedInstance;
}

#pragma mark - public method

- (void)showNativeAd:(UIViewController *)viewController targetView:(UIView *)targetView frame:(CGRect)frame
{
    self.nativeExpressAdView = [[GADNativeExpressAdView alloc] initWithAdSize:GADAdSizeFromCGSize(frame.size)
                                                                       origin:frame.origin];
    self.nativeExpressAdView.adUnitID = GAD_NATIVE_UNIT_ID;
    self.nativeExpressAdView.rootViewController = viewController;
    self.nativeExpressAdView.delegate = self;
    [targetView addSubview:self.nativeExpressAdView];
    
    GADRequest *request = [GADRequest request];
    if (GAD_TEST_MODE) {
        request.testDevices = @[kGADSimulatorID];
    }
    [self.nativeExpressAdView loadRequest:request];
}

- (UIView *)nativeAd:(UIViewController *)viewController frame:(CGRect)frame
{
    self.nativeExpressAdView = [[GADNativeExpressAdView alloc] initWithAdSize:GADAdSizeFromCGSize(frame.size)
                                                                       origin:frame.origin];
    self.nativeExpressAdView.adUnitID = GAD_NATIVE_UNIT_ID;
    self.nativeExpressAdView.rootViewController = viewController;
    self.nativeExpressAdView.delegate = self;
    
    GADRequest *request = [GADRequest request];
    if (GAD_TEST_MODE) {
        request.testDevices = @[kGADSimulatorID];
    }
    [self.nativeExpressAdView loadRequest:request];
    
    return self.nativeExpressAdView;
}

#pragma mark - delegate method

- (void)nativeExpressAdViewDidReceiveAd:(GADNativeExpressAdView *)nativeExpressAdView
{
    //NSLog(@"nativeExpressAdViewDidReceiveAd");
}

- (void)nativeExpressAdView:(GADNativeExpressAdView *)nativeExpressAdView didFailToReceiveAdWithError:(GADRequestError *)error
{
    //NSLog(@"nativeExpressAdView: didFailToReceiveAdWithError");
}

- (void)nativeExpressAdViewWillPresentScreen:(GADNativeExpressAdView *)nativeExpressAdView
{
    //NSLog(@"nativeExpressAdViewWillPresentScreen");
}

- (void)nativeExpressAdViewWillDismissScreen:(GADNativeExpressAdView *)nativeExpressAdView
{
    //NSLog(@"nativeExpressAdViewWillDismissScreen");
}

- (void)nativeExpressAdViewDidDismissScreen:(GADNativeExpressAdView *)nativeExpressAdView
{
    //NSLog(@"nativeExpressAdViewDidDismissScreen");
}

- (void)nativeExpressAdViewWillLeaveApplication:(GADNativeExpressAdView *)nativeExpressAdView
{
    //NSLog(@"nativeExpressAdViewWillLeaveApplication");
}

@end
