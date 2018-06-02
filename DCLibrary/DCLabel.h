//
//  DCLabel.h
//
//  Created by Masaki Hirokawa on 2013/06/10.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DCLabel : UILabel

#pragma mark - public method
+ (UILabel *)planeLabel:(CGRect)rect text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor;
+ (UILabel *)oneLineLabel:(CGRect)rect text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor;
+ (UILabel *)multiLineLabel:(CGRect)rect text:(NSString *)text font:(UIFont *)font lineHeight:(CGFloat)lineHeight textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor;
+ (UILabel *)roundRectLabel:(CGRect)rect text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor cornerRadious:(CGFloat)cornerRadius;
+ (UILabel *)roundRectLabelWithBorder:(CGRect)rect text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadious:(CGFloat)cornerRadius;

@end
