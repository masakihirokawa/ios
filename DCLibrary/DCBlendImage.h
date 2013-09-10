//
//  DCBlendImage.h
//
//  Created by Masaki Hirokawa on 2013/09/09.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCBlendImage : UIImage

#pragma mark method prototype
+ (UIImage *)blendImage:(UIImage *)baseImage blendImage:(UIImage *)blendImage blendMode:(CGBlendMode)blendMode blendAlpha:(CGFloat)blendAlpha rect:(CGRect)rect;
+ (UIImageView *)blendImageView:(UIImage *)baseImage blendImage:(UIImage *)blendImage blendMode:(CGBlendMode)blendMode blendAlpha:(CGFloat)blendAlpha rect:(CGRect)rect;

@end
