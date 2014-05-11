//
//  DCWebView.h
//
//  Created by Masaki Hirokawa on 2014/01/04.
//  Copyright (c) 2014 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCWebView : UIWebView <UIWebViewDelegate>

#pragma mark - property
@property (nonatomic, retain) UIActivityIndicatorView *indicator;

#pragma mark - public method
- (void)loadUrl:(NSString *)targetUrl view:(UIView *)view;
- (void)bounces:(BOOL)isAllow;

@end
