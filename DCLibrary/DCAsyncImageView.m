//
//  DCAsyncImageView.m
//
//  Created by Dolice on 2014/05/27.
//  Copyright (c) 2014 Masaki Hirokawa. All rights reserved.
//

#import "DCAsyncImageView.h"

@implementation DCAsyncImageView

CGFloat const AI_SMALL_SIZE = 20;
CGFloat const AI_LARGE_SIZE = 50;

typedef NS_ENUM(NSUInteger, indicatorType) {
    AI_GRAY        = 1,
    AI_WHITE_SMALL = 2,
    AI_WHITE_LARGE = 3
};

#pragma mark -

// サーバから画像を読み込み
- (void)loadImage:(NSString *)url backgroundColor:(UIColor *)backgroundColor showIndicator:(BOOL)showIndicator indicatorType:(NSUInteger)indicatorType
{
    [self abort];
    
    // 背景色指定
    if (backgroundColor == nil) {
        self.backgroundColor = [UIColor clearColor];
    } else {
        self.backgroundColor = backgroundColor;
    }
    
    // サーバに画像をリクエスト
    data = [[NSMutableData alloc] initWithCapacity:0];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                         cachePolicy:NSURLRequestUseProtocolCachePolicy
                                     timeoutInterval:30.0];
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    // アクティビティインジケータ表示
    if (showIndicator) {
        [self showActivityIndicator:indicatorType];
    }
}

// サーバからレスポンスを受け取った時の処理
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [data setLength:0];
}

// サーバからデータを受け取った時の処理
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)nsdata
{
    [data appendData:nsdata];
}

// サーバからエラーが返ってきた時の処理
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self abort];
}

// 読み込みが完了した時の処理
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // 画像を表示
    self.image = [UIImage imageWithData:data];
    
    // アクティビティインジケータ非表示
    [self stopActivityIndicator];
    
    // 通信終了
    [self abort];
}

// 通信終了
- (void)abort
{
    if (conn != nil) {
        [conn cancel];
        conn = nil;
    }
    
    if (data != nil) {
        data = nil;
    }
}

#pragma mark - Activity indicator

// アクティビティインジケータ表示
- (void)showActivityIndicator:(NSUInteger)indicatorType
{
    _indicator = [[UIActivityIndicatorView alloc] init];
    
    switch (indicatorType) {
        case AI_GRAY:
            _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            break;
        case AI_WHITE_SMALL:
            _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            break;
        case AI_WHITE_LARGE:
            _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            break;
    }
    
    if (indicatorType == AI_WHITE_LARGE) {
        _indicator.frame = CGRectMake(0, 0, AI_LARGE_SIZE, AI_LARGE_SIZE);
    } else {
        _indicator.frame = CGRectMake(0, 0, AI_SMALL_SIZE, AI_SMALL_SIZE);
    }
    
    _indicator.center = self.center;
    _indicator.hidesWhenStopped = YES;
    [_indicator startAnimating];
    [self addSubview:_indicator];
}

// アクティビティインジケータ非表示
- (void)stopActivityIndicator
{
    [_indicator stopAnimating];
}

@end
