//
//  DCImage.h
//
//  Created by Masaki Hirokawa on 2013/05/24.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCImage : UIImage

#pragma mark - enumerator
typedef NS_ENUM(NSUInteger, blurEffectStyleId) {
    BLUR_EFFECT_REGULAR     = 0,
    BLUR_EFFECT_PROMINENT   = 1,
    BLUR_EFFECT_EXTRA_LIGHT = 3,
    BLUR_EFFECT_LIGHT       = 4,
    BLUR_EFFECT_DARK        = 5
};

#pragma mark - public method
+ (UIImageView *)imageView:(NSString *)imageName imageExt:(NSString *)ext rect:(CGRect)rect;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)resize:(UIImage *)image rect:(CGRect)rect;
+ (UIVisualEffectView *)blurEffectView:(CGRect)frame styleId:(NSUInteger)styleId;
+ (BOOL)availableBlurEffects;
+ (NSString *)getImgFileName:(NSString *)src;
+ (UIImage *)getUIImageFromResources:(NSString*)fileName ext:(NSString*)ext;

@end
