//
//  DCButton.m
//
//  Created by Masaki Hirokawa on 2013/06/04.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCButton.h"

@implementation DCButton

#pragma mark -

// 通常のボタン取得
+ (UIButton *)planeButton:(CGRect)frame text:(NSString *)text delegate:(id)delegate action:(SEL)action tag:(NSInteger)tag
{
    // ボタン生成
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:text forState:UIControlStateNormal];
    [button sizeToFit];
    button.frame = frame;
    button.tag = tag;
    
    // 画面が変わってもボタンの位置を自動調整
    button.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    // ボタンタップ時のイベント定義
    [button addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

// 画像ボタン取得
+ (UIButton *)imageButton:(CGRect)frame img:(UIImage *)img isHighlighte:(BOOL)isHighlighte on_img:(UIImage *)on_img delegate:(id)delegate action:(SEL)action tag:(NSInteger)tag
{
    // ボタン生成
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTag:tag];
    
    // ボタンの画像を指定
    [button setImage:img forState:UIControlStateNormal];
    button.adjustsImageWhenDisabled = NO;
    if (!isHighlighte) {
        button.showsTouchWhenHighlighted = NO;
        button.adjustsImageWhenHighlighted = NO;
    } else if (on_img != nil || ![on_img isEqual:[NSNull null]]) {
        [button setImage:on_img forState:UIControlStateHighlighted];
    }
    
    // ボタンタップ時のイベント定義
    [button addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end
