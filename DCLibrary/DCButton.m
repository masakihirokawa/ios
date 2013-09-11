//
//  DCButton.m
//
//  Created by Masaki Hirokawa on 2013/06/04.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCButton.h"

@implementation DCButton

//通常のボタン
+ (UIButton *)planeButton:(CGRect)frame text:(NSString *)text delegate:(id)delegate action:(SEL)action tag:(NSInteger)tag
{
    //ボタン作成
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:text forState:UIControlStateNormal];
    
    //ボタンのフレームを指定
    [button sizeToFit];
    button.frame = frame;
    
    //画面が変わってもボタンの位置を自動調整
    button.autoresizingMask =
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin;
    
    //ボタンのタグを指定
    button.tag = tag;
    
    //ボタンをタップした時に指定のメソッドを呼ぶ
    [button addTarget:delegate
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    return (button);
}

//画像ボタン
+ (UIButton *)imageButton:(CGRect)frame img:(UIImage *)img isHighlighte:(BOOL)isHighlighte on_img:(UIImage *)on_img delegate:(id)delegate action:(SEL)action tag:(NSInteger)tag
{
    //ボタン作成
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //ボタンのフレームを指定
	[button setFrame:frame];
    
    //ボタンの画像を指定
	[button setImage:img forState:UIControlStateNormal];
	button.adjustsImageWhenDisabled = NO;
    if (!isHighlighte) {
        button.showsTouchWhenHighlighted = NO;
        button.adjustsImageWhenHighlighted = NO;
    } else if(on_img != nil || ![on_img isEqual:[NSNull null]]) {
        [button setImage:on_img forState:UIControlStateHighlighted];
    }
    
    //ボタンのタグを指定
	[button setTag:tag];
    
    //ボタンをタップした時に指定のメソッドを呼ぶ
	[button addTarget:delegate
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
	return (button);
}

@end
