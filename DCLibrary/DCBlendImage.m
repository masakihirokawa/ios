//
//  DCBlendImage.m
//
//  Created by Masaki Hirokawa on 2013/09/09.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCBlendImage.h"

@implementation DCBlendImage

#pragma mark blend image

//合成された UIImage取得
+ (UIImage *)blendImage:(UIImage *)baseImage blendImage:(UIImage *)blendImage blendMode:(CGBlendMode)blendMode blendAlpha:(CGFloat)blendAlpha rect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    
    [baseImage drawInRect:rect];
    [blendImage drawInRect:rect blendMode:blendMode alpha:blendAlpha];
    
    UIImage *compositeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return compositeImage;
}

#pragma mark blend image view

//合成された UIImageView取得
+ (UIImageView *)blendImageView:(UIImage *)baseImage blendImage:(UIImage *)blendImage blendMode:(CGBlendMode)blendMode blendAlpha:(CGFloat)blendAlpha rect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);

    [baseImage drawInRect:rect];
    [blendImage drawInRect:rect blendMode:blendMode alpha:blendAlpha];
    
    UIImage *compositeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *compositeImageView = [[UIImageView alloc] initWithImage:compositeImage];
    
    return compositeImageView;
}

@end
