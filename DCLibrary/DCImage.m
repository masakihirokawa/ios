//
//  DCImage.m
//
//  Created by Masaki Hirokawa on 2013/05/24.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCImage.h"

@implementation DCImage

#pragma mark - Image View

// 画像の取得
+ (UIImageView *)imageView:(NSString *)imageName imageExt:(NSString *)imageExt rect:(CGRect)rect
{
    UIImage *image = [DCImage getUIImageFromResources:imageName ext:imageExt];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin;
    return (imageView);
}

#pragma mark - Mask Image

// 画像にマスク適用
+ (UIImage *)mask:(UIImage *)image withMask:(UIImage *)maskImage
{
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    return ([UIImage imageWithCGImage:masked]);
}

#pragma mark - Resize Image

// 画像のリサイズ
+ (UIImage *)resize:(UIImage *)image rect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    UIGraphicsEndImageContext();
    return (resizedImage);
}

#pragma mark - getter method

// 画像ファイル名取得
+ (NSString *)getImgFileName:(NSString *)src
{
    NSArray *a = [src componentsSeparatedByString:@"."];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    BOOL is4inch = screenSize.width == 320.0 && screenSize.height == 568.0;
    if(is4inch) {
        return [NSString stringWithFormat:@"%@-568h@2x.%@", [a objectAtIndex:0], [a objectAtIndex:1]];
    }
    return [NSString stringWithFormat:@"%@@2x.%@", [a objectAtIndex:0], [a objectAtIndex:1]];
}

// 画像ファイル取得
+ (UIImage *)getUIImageFromResources:(NSString*)fileName ext:(NSString*)ext
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:ext];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
    return (img);
}

@end
