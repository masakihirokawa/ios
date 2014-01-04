//
//  DCWebView.m
//  TheMystery
//
//  Created by Dolice on 2014/01/04.
//  Copyright (c) 2014年 Dolice. All rights reserved.
//

#import "DCWebView.h"

@implementation DCWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        self.scalesPageToFit = YES;
        self.opaque = NO;
    }
    return self;
}

#pragma mark - delegate method

// ページ読込開始時にインジケータ表示
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // ステータスバーのインジケータ表示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// ページ読込完了時にインジケータ非表示
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // アクティビティインジケータ非表示
    [self stopActivityIndicatorAnimation];
    
    // ステータスバーのインジケータ非表示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - public method

// URL読み込み
- (void)loadUrl:(NSString *)targetUrl view:(UIView *)view
{
    NSURL *url = [NSURL URLWithString:targetUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self loadRequest:request];

    // アクティビティインジケータ表示
    [self startActivityIndicatorAnimation:view];
}

// バウンスさせるか
- (void)bounces:(BOOL)isAllow
{
    for (id subview in self.subviews) {
        if ([[subview class] isSubclassOfClass: [UIScrollView class]]) {
            ((UIScrollView *)subview).bounces = isAllow;
        }
    }
}

#pragma mark - private method

// アクティビティインジケータ表示
- (void)startActivityIndicatorAnimation:(UIView *)view
{
    _indicator = [[UIActivityIndicatorView alloc] init];
    _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _indicator.frame = CGRectMake(0, 0, 20, 20);
    _indicator.center = view.center;
    _indicator.hidesWhenStopped = YES;
    [_indicator startAnimating];
    [view addSubview:_indicator];
}

// アクティビティインジケータ非表示
- (void)stopActivityIndicatorAnimation
{
    [_indicator stopAnimating];
}

@end
