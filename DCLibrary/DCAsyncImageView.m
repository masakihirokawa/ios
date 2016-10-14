//
//  DCAsyncImageView.m
//
//  Created by Dolice on 2014/05/27.
//  Copyright (c) 2014 Masaki Hirokawa. All rights reserved.
//

#import "DCAsyncImageView.h"

@implementation DCAsyncImageView

#pragma mark -

// サーバから画像を読み込み
- (void)loadImage:(NSString *)url backgroundColor:(UIColor *)backgroundColor showIndicator:(BOOL)showIndicator indicatorType:(NSUInteger)indicatorType delegate:(id)delegate
{
    [self abort];
    
    // 背景色指定
    if (backgroundColor == nil) {
        self.backgroundColor = [UIColor clearColor];
    } else {
        self.backgroundColor = backgroundColor;
    }
    
    // レスポンスデータ初期化
    _responseData = [[NSMutableData alloc] initWithCapacity:0];
    
    // 通信処理開始
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.timeoutIntervalForRequest  = DC_AIV_TIME_OUT_REQUEST;
    sessionConfiguration.timeoutIntervalForResource = DC_AIV_TIME_OUT_RESOURCE;
    
    _session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                             delegate:self
                                        delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                             //cachePolicy:NSURLRequestUseProtocolCachePolicy
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                         timeoutInterval:30.0];
    
    NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:request];
    
    [dataTask resume];
    
    // アクティビティインジケータ表示
    if (showIndicator) {
        [self showActivityIndicator:indicatorType];
    }
}

#pragma mark - delegate method

// サーバからレスポンスを受け取った時の処理
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    //NSLog(@"サーバからレスポンスを受け取った時の処理");
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        completionHandler(NSURLSessionResponseAllow);
    } else {
        completionHandler(NSURLSessionResponseCancel);
    }
    
    [_responseData setLength:0];
}

// サーバからデータを受け取った時の処理
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    //NSLog(@"サーバからデータを受け取った時の処理");
    
    [_responseData appendData:data];
}

// サーバからレスポンスが返ってきた時の処理
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error) {
        //NSLog(@"正常終了");
        
        // 画像を表示
        self.image = [UIImage imageWithData:_responseData];
        
        // アクティビティインジケータ非表示
        [self stopActivityIndicator];
        
        // 通信終了
        [self abort];
    } else {
        //NSLog(@"エラー終了");
        
        // 通信終了
        [self abort];
    }
}

#pragma mark - Abort

// 通信終了処理
- (void)abort
{
    //NSLog(@"通信終了処理");
    
    if (_session != nil) {
        [_session invalidateAndCancel];
        _session = nil;
    }
    
    if (_responseData != nil) {
        _responseData = nil;
    }
}

#pragma mark - Activity indicator

// アクティビティインジケータ表示
- (void)showActivityIndicator:(NSUInteger)indicatorType
{
    _indicator = [[UIActivityIndicatorView alloc] init];
    
    switch (indicatorType) {
        case DC_AIV_AI_GRAY:
            _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            
            break;
        case DC_AIV_AI_WHITE_SMALL:
            _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            
            break;
        case DC_AIV_AI_WHITE_LARGE:
            _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            
            break;
    }
    
    _indicator.frame = indicatorType == DC_AIV_AI_WHITE_LARGE ? DC_AIV_AI_LARGE_RECT : DC_AIV_AI_SMALL_RECT;
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
