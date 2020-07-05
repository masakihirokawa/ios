//
//  DCURLSession.m
//
//  Created by Dolice on 2016/07/26.
//  Copyright © 2016 Dolice. All rights reserved.
//

#import "DCURLSession.h"

@implementation DCURLSession

#pragma mark - public method

// 通信処理開始
- (void)start:(NSString *)url httpMethod:(NSString *)httpMethod alternateStr:(NSString *)alternateStr
{
    // エラー発生時の代替テキスト保持
    _alternateStr = alternateStr;
    
    // 通信処理開始
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.timeoutIntervalForRequest  = TIME_OUT_REQUEST;
    sessionConfiguration.timeoutIntervalForResource = TIME_OUT_RESOURCE;
    
    _session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                             delegate:self
                                        delegateQueue:[NSOperationQueue mainQueue]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL:[NSURL URLWithString:url]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setValue      :@"identity" forHTTPHeaderField:@"Accept-encording"];
    [request setValue      :@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [request setHTTPMethod :httpMethod];
    
    NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:request];
    
    [dataTask resume];
}

#pragma mark - delegate method

// サーバからレスポンスを受け取った時の処理
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 didReceiveResponse:(NSURLResponse *)response
  completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        completionHandler(NSURLSessionResponseAllow);
    } else {
        completionHandler(NSURLSessionResponseCancel);
    }
}

// サーバからデータを受け取った時の処理
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    _responseData = [NSMutableData data];
    [_responseData appendData:data];
}

// サーバからレスポンスが返ってきた時の処理
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error) {
        // 正常終了
        _responseStr = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    } else {
        // エラー終了
        _responseStr = _alternateStr;
    }
    
    [session invalidateAndCancel];
}

@end
