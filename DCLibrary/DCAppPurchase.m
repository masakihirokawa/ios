//
//  DCAppPurchase.m
//
//  Created by Masaki Hirokawa on 13/09/02.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCAppPurchase.h"

@implementation DCAppPurchase

@synthesize dc_delegate;
@synthesize delegate;

#pragma mark - Shared Manager

static DCAppPurchase *_sharedInstance = nil;

+ (DCAppPurchase *)sharedManager
{
    if (!_sharedInstance) {
        _sharedInstance = [[DCAppPurchase alloc] init];
    }
    return _sharedInstance;
}

#pragma mark - Init

- (id)init
{
    if (self = [super init]) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

#pragma mark - In App Purchase

// アプリ内課金処理を開始
- (void)startPurchase:(NSString *)productId view:(id)view
{
    if (![self canMakePayments]) {
        // アプリ内課金が許可されていなければアラートを出して終了
        [self showAlert:@"アプリ内課金が許可されていません"];
        return;
    }
    
    // 処理中であれば処理しない
    if (isProccessing_) {
        return;
    }
    
    // 処理中フラグを立てる
    isProccessing_ = YES;
    
    // リストアフラグ初期化
    isRestored_ = NO;
    
    // プロダクトID保持
    productId_ = productId;
    
    // View保持
    view_ = view;
    
    // プロダクト情報の取得処理を開始
    NSSet *set = [NSSet setWithObjects:productId_, nil];
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    productsRequest.delegate = self;
    [productsRequest start];
}

// デリゲートメソッド (プロダクト情報を取得)
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    // レスポンスがなければエラー処理
    if (response == nil) {
        [self showAlert:@"レスポンスがありません"];
        return;
    }
    
    // プロダクトIDが無効な場合はアラートを出して終了
    if ([response.invalidProductIdentifiers count] > 0) {
        [self showAlert:@"プロダクトIDが無効です"];
        return;
    }
    
    // 購入処理開始
    for (SKProduct *product in response.products) {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

// 購入完了時の処理
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    // トランザクション記録
    [self recordTransaction:transaction];
    
    // コンテンツ提供
    [self provideContent:transaction.payment.productIdentifier];
}

// リストア完了時の処理
- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    //リストアフラグを立てる
    isRestored_ = YES;
    
    // トランザクション記録
    [self recordTransaction:transaction];
    
    // コンテンツ提供
    [self provideContent:transaction.originalTransaction.payment.productIdentifier];
}

// トランザクション記録
- (void)recordTransaction:(SKPaymentTransaction *)transaction
{
    //NSLog(@"%@", transaction);
}

// コンテンツ提供
- (void)provideContent:(NSString *)productIdentifier
{
    // ここでアイテム付与を行う
    
    
}

// デリゲートメソッド (購入処理開始後に状態が変わるごとに随時コールされる)
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        if (transaction.transactionState == SKPaymentTransactionStatePurchasing) {
            // 購入処理中
            [self startActivityIndicator:view_
                                  center:CGPointMake(160, [self is4inch] ? SCREEN_HEIGHT_4INCH / 2 : SCREEN_HEIGHT / 2)
                                 styleId:AI_WHITE
                        hidesWhenStopped:YES];
        } else if (transaction.transactionState == SKPaymentTransactionStatePurchased) {
            // 購入処理成功
            [self showAlert:@"購入ありがとうございます"];
            
            // 該当するプロダクトのロックを解除する
            [self completeTransaction:transaction];
            
            // インジケータ非表示
            [self stopActivityIndicator];
            
            // 処理中フラグを下ろす
            isProccessing_ = NO;
            
            // ペイメントキューからトランザクションを削除
            [queue finishTransaction:transaction];
        } else if (transaction.transactionState == SKPaymentTransactionStateFailed) {
            // ユーザーによるキャンセルでなければアラートを出す
            if (transaction.error.code != SKErrorPaymentCancelled) {
                // 購入処理失敗の場合はアラート表示
                [self showAlert:[transaction.error localizedDescription]];
            }
            
            // インジケータ非表示
            [self stopActivityIndicator];
            
            // 処理中フラグを下ろす
            isProccessing_ = NO;
            
            // ペイメントキューからトランザクションを削除
            [queue finishTransaction:transaction];
        } else if (transaction.transactionState == SKPaymentTransactionStateRestored) {
            // リストア処理開始
            [self showAlert:@"購入アイテムを復元しました"];
            
            // 購入済みのプロダクトのロックを再解除する
            [self restoreTransaction:transaction];
            
            // インジケータ非表示
            [self stopActivityIndicator];
            
            // 処理中フラグを下ろす
            isProccessing_ = NO;
            
            // ペイメントキューからトランザクションを削除
            [queue finishTransaction:transaction];
        }
    }
}

#pragma mark - Restore

// リストア開始
- (void)restorePurchase:(NSString *)productId view:(id)view;
{
    // 処理中であれば処理しない
    if (isProccessing_) {
        return;
    }
    
    // 処理中フラグを立てる
    isProccessing_ = YES;
    
    // リストアフラグ初期化
    isRestored_ = NO;
    
    // プロダクトID保持
    productId_ = productId;
    
    // View保持
    view_ = view;
    
    // 購入済みプラグインのリストア処理を開始する
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

// リストア完了
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    // 購入済みでなかった場合アラート表示
    if (!isRestored_) {
        [self showAlert:@"リストアするアイテムがありません"];
    }
    
    // 処理中フラグを下ろす
    isProccessing_ = NO;
}

// リストアエラー
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    for (SKPaymentTransaction *transaction in queue.transactions) {
        [self showAlert:@"リストアに失敗しました"];
    }
}

#pragma mark - delegate method

// デリゲートメソッド (終了通知)
- (void)requestDidFinish:(SKRequest *)request
{
}

// デリゲートメソッド (アクセスエラー)
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    [self showAlert:[error localizedDescription]];
}

#pragma mark - Activity Indicator

typedef NS_ENUM(NSUInteger, activityIndicatorStyles) {
    AI_GRAY        = 1,
    AI_WHITE       = 2,
    AI_WHITE_LARGE = 3
};

// アクティビティインジケータのアニメーション開始
- (void)startActivityIndicator:(id)view center:(CGPoint)center styleId:(NSInteger)styleId hidesWhenStopped:(BOOL)hidesWhenStopped
{
    // インジケーター初期化
    indicator_ = [[UIActivityIndicatorView alloc] init];
    
    // スタイルを設定
    switch (styleId) {
        case AI_GRAY:
            indicator_.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            break;
        case AI_WHITE:
            indicator_.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            break;
        case AI_WHITE_LARGE:
            indicator_.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            break;
    }
    
    // スタイルに応じて寸法変更
    if (indicator_.activityIndicatorViewStyle == UIActivityIndicatorViewStyleWhiteLarge) {
        indicator_.frame = CGRectMake(0, 0, AI_LARGE_SIZE, AI_LARGE_SIZE);
    } else {
        indicator_.frame = CGRectMake(0, 0, AI_SMALL_SIZE, AI_SMALL_SIZE);
    }
    
    // 座標をセンターに指定
    indicator_.center = center;
    
    // 停止した時に隠れるよう設定
    indicator_.hidesWhenStopped = hidesWhenStopped;
    
    // インジケーターアニメーション開始
    [indicator_ startAnimating];
    
    // オーバーレイ表示
    indicatorOverlay_ = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self is4inch] ? SCREEN_HEIGHT_4INCH : SCREEN_HEIGHT)];
    indicatorOverlay_.backgroundColor = AI_BG_COLOR;
    [view addSubview:indicatorOverlay_];
    
    // 画面に追加
    [view addSubview:indicator_];
}

// アクティビティインジケータのアニメーション停止
- (void)stopActivityIndicator
{
    [indicatorOverlay_ removeFromSuperview];
    [indicator_ stopAnimating];
}

// アクティビティインジケータがアニメーション中であるか
- (BOOL)isAnimatingActivityIndicator
{
    return [indicator_ isAnimating];
}

#pragma mark - Utils

// アプリ内課金が許可されているか
- (BOOL)canMakePayments
{
    return [SKPaymentQueue canMakePayments];
}

// アラート表示
- (void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

// 4インチ端末であるか
- (BOOL)is4inch
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    return screenSize.width == SCREEN_WIDTH && screenSize.height == SCREEN_HEIGHT_4INCH;
}

@end