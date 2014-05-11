//
//  DCAppPurchase.h
//
//  Created by Masaki Hirokawa on 13/09/02.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

#define AI_LARGE_SIZE       50
#define AI_SMALL_SIZE       20
#define AI_BG_COLOR         [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]
#define SCREEN_WIDTH        320
#define SCREEN_HEIGHT       480
#define SCREEN_HEIGHT_4INCH 568

@protocol DCAppPurchaseDelegate;

@interface DCAppPurchase : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver> {
    id<DCAppPurchaseDelegate> _dc_delegate;
    id                        _delegate;
    NSString                  *productId_;
    id                        view_;
    BOOL                      isProccessing_;
    BOOL                      isRestored_;
    UIActivityIndicatorView   *indicator_;
    UIView                    *indicatorOverlay_;
}

#pragma mark - property
@property (nonatomic, assign) id<DCAppPurchaseDelegate> dc_delegate;
@property (nonatomic, assign) id delegate;

#pragma mark - public method
+ (DCAppPurchase *)sharedManager;
- (void)startPurchase:(NSString *)productId view:(id)view;
- (void)restorePurchase:(NSString *)productId view:(id)view;

@end

#pragma mark - delegate method
@protocol DCAppPurchaseDelegate <NSObject>
@optional
- (void)DCAppPurchaseDidFinish;
@end
