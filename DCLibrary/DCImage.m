//
//  DCImage.m
//
//  Created by Masaki Hirokawa on 2013/05/24.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCImage.h"

@implementation DCImage

#pragma mark - Image View

// イメージビューの取得
+ (UIImageView *)imageView:(NSString *)imageName imageExt:(NSString *)imageExt rect:(CGRect)rect
{
    UIImage *const image = [DCImage getUIImageFromResources:imageName ext:imageExt];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    return imageView;
}

#pragma mark - Resize image

// 画像のリサイズ
+ (UIImage *)resize:(UIImage *)image rect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

#pragma mark - Fill image

// イメージの塗りカラーを指定して取得
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect const rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef const context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Blur effect

// ぼかし効果付きの背景取得
+ (UIVisualEffectView *)blurEffectView:(CGRect)frame styleId:(NSUInteger)styleId
{
    UIBlurEffect *blurEffect;
    switch (styleId) {
        case BLUR_EFFECT_REGULAR:
            if (@available(iOS 10.3, *)) {
                blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
            } else {
                blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            }
            
            break;
            
        case BLUR_EFFECT_PROMINENT:
            if (@available(iOS 10.3, *)) {
                blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];
            } else {
                blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            }
            
            break;
            
        case BLUR_EFFECT_EXTRA_LIGHT:
            blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            
            break;
            
        case BLUR_EFFECT_LIGHT:
            blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            
            break;
            
        case BLUR_EFFECT_DARK:
            blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            
            break;
            
        default:
            if (@available(iOS 10.3, *)) {
                blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
            } else {
                blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            }
            
            break;
    }
    
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = frame;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    return blurEffectView;
}

// ぼかし効果が使用可能か取得
+ (BOOL)availableBlurEffects
{
    return !UIAccessibilityIsReduceTransparencyEnabled();
}

#pragma mark - getter method

// 画像ファイル名取得
+ (NSString *)getImgFileName:(NSString *)src
{
    NSArray *const a = [src componentsSeparatedByString:@"."];
    CGSize const screenSize = [[UIScreen mainScreen] bounds].size;
    BOOL const is4inch = screenSize.width == 320.0 && screenSize.height == 568.0;
    if (is4inch) {
        return [NSString stringWithFormat:@"%@-568h@2x.%@", [a objectAtIndex:0], [a objectAtIndex:1]];
    }
    
    return [NSString stringWithFormat:@"%@@2x.%@", [a objectAtIndex:0], [a objectAtIndex:1]];
}

// 画像ファイル取得
+ (UIImage *)getUIImageFromResources:(NSString *)fileName ext:(NSString *)ext
{
    NSString *const path = [[NSBundle mainBundle] pathForResource:fileName ofType:ext];
    
    return [[UIImage alloc] initWithContentsOfFile:path];
}

@end
