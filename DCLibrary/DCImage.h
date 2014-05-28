//
//  DCImage.h
//
//  Created by Masaki Hirokawa on 2013/05/24.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCImage : UIImage

#pragma mark - public method
+ (UIImageView *)imageView:(NSString *)imageName imageExt:(NSString *)ext rect:(CGRect)rect;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)mask:(UIImage *)image withMask:(UIImage *)maskImage;
+ (UIImage *)resize:(UIImage *)image rect:(CGRect)rect;
+ (NSString *)getImgFileName:(NSString *)src;
+ (UIImage *)getUIImageFromResources:(NSString*)fileName ext:(NSString*)ext;

@end
