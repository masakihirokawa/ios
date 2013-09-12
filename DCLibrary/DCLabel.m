//
//  DCLabel.m
//
//  Created by Masaki Hirokawa on 2013/06/10.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCLabel.h"

@implementation DCLabel

// 通常のラベル取得
+ (UILabel *)planeLabel:(CGRect)rect text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor
{
    UILabel *label = [DCLabel label:rect
                               text:text font:font textColor:textColor textAlignment:textAlignment
                    backgroundColor:backgroundColor];
    return (label);
}

// 角丸のラベル取得
+ (UILabel *)roundRectLabel:(CGRect)rect text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor cornerRadious:(CGFloat)cornerRadius
{
    UILabel *label = [DCLabel label:rect
                               text:text font:font textColor:textColor textAlignment:textAlignment
                    backgroundColor:backgroundColor];
    [[label layer] setCornerRadius:cornerRadius];
    [label setClipsToBounds:YES];
    return (label);
}

//ラベル取得
+ (UILabel *)label:(CGRect)rect text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;
    label.backgroundColor = backgroundColor;
    return (label);
}

@end
