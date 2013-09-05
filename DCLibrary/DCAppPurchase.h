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
    UIActivityIndicatorView   *indicator_;
    UIView                    *indicatorOverlay_;
}

+ (DCAppPurchase *)sharedManager;

#pragma mark property prototype
@property (nonatomic, assign) id<DCAppPurchaseDelegate> dc_delegate;
@property (nonatomic, assign) id delegate;

#pragma mark method prototype
- (void)startPurchase:(NSString *)productId view:(id)view;
- (void)restorePurchase;

@end

#pragma mark delegate prototype
@protocol DCAppPurchaseDelegate <NSObject>
- (void)DCAppPurchaseDidFinish;
@end
