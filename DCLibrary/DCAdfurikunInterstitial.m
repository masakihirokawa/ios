//
//  DCAdfurikunInterstitial.m
//
//  Created by Dolice on 2020/07/09.
//

#import "DCAdfurikunInterstitial.h"

@implementation DCAdfurikunInterstitial

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

#pragma mark - Adfurikun Interstitial Ad

// Adfurikunインタースティシャル広告読み込み
- (void)loadInterstitial:(UIViewController *)viewController
{
    if (![viewController isEqual:self.rootViewController]) {
        self.rootViewController = viewController;
    }
    
    adfurikunInterstitial = [ADFmyInterstitial getInstance:ADFURIKUN_INTERS_UNIT_ID delegate:self];
    [adfurikunInterstitial load];
}

// 広告の読み込みが完了した時に呼ばれる
- (void)AdsFetchCompleted:(NSString *)appID isTestMode:(BOOL)isTestMode_inApp
{
    if (adfurikunInterstitial != nil && [adfurikunInterstitial isPrepared] ) {
        [adfurikunInterstitial playWithPresentingViewController:self.rootViewController];
    }
}

// 広告の読み込みに失敗した時に呼ばれる
- (void)AdsFetchFailed:(NSString *)appID error:(NSError *)error
{
}

// 広告の表示を開始した時に呼ばれる
- (void)AdsDidShow:(NSString *)appID adNetworkKey:(NSString *)adNetworkKey
{
}

// 広告の再生が完了した時に呼ばれる
- (void)AdsDidCompleteShow:(NSString *)appID
{
}

// 広告を閉じた時に呼ばれる
- (void)AdsDidHide:(NSString *)appID
{
}

// 広告の再生エラー時に呼ばれる
- (void)AdsPlayFailed:(NSString *)appID
{
}

@end
