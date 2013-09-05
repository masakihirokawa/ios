//
//  DCImage.m
//
//  Created by Masaki Hirokawa on 2013/05/24.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCImage.h"

@implementation DCImage

@synthesize backgroundImageX      = _backgroundImageX;
@synthesize backgroundImageY      = _backgroundImageY;
@synthesize backgroundImageWidth  = _backgroundImageWidth;
@synthesize backgroundImageHeight = _backgroundImageHeight;
@synthesize backgroundImageExt    = _backgroundImageExt;

#pragma mark init

- (id)init
{
    if (self = [super init]) {
        [self setBackgroundImageRectangle];
        [self setBackgroundImageType];
        [self setBackgroundImageExt:BG_IMG_EXT];
    }
    return self;
}

#pragma mark image

//画像の取得
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

#pragma mark background image

//背景画像のレクタングル定義
- (void)setBackgroundImageRectangle
{
    _backgroundImageX      = 0;
    _backgroundImageY      = 0;
    _backgroundImageWidth  = [self backgroundImageWidth];
    _backgroundImageHeight = [self backgroundImageHeight];
}

//背景画像のファイル名接尾詞定義
- (void)setBackgroundImageType
{
    _backgroundImageType = [NSArray arrayWithObjects:
                            BG_IMG_TYPE_IPHONE5,
                            BG_IMG_TYPE_IPHONE4,
                            BG_IMG_TYPE_IPAD,
                            BG_IMG_TYPE_IPAD_RETINA,
                            nil];
}

//背景画像の拡張子定義
- (void)setBackgroundImageExt:(NSString *)ext
{
    _backgroundImageExt = ext;
}

//背景画像のファイル名取得
- (NSString *)backgroundImageFile:(NSString *)imageTitle
{
    return ([NSString stringWithFormat:@"%@%@%@",
             imageTitle, [self backgroundImageType], _backgroundImageExt]);
}

//背景画像の名前を取得 (拡張子を含まない)
- (NSString *)backgroundImageName:(NSString *)imageTitle
{
    return ([NSString stringWithFormat:@"%@%@",
             imageTitle, [self backgroundImageType]]);
}

//背景画像のファイル名接尾詞取得
- (NSString *)backgroundImageType
{
    if ([DCDevice isIphone5]) {
        return ([_backgroundImageType objectAtIndex:0]);
    } else if ([DCDevice isIphone4]) {
        return ([_backgroundImageType objectAtIndex:1]);
    }
    else if ([DCDevice isIpad]) {
        return ([_backgroundImageType objectAtIndex:2]);
    } else if ([DCDevice isIpadRetina]) {
        return ([_backgroundImageType objectAtIndex:3]);
    }
    return ([_backgroundImageType objectAtIndex:0]);
}

//背景画像の横幅取得
- (int)backgroundImageWidth
{
    if ([DCDevice isIphone5]) {
        return (BG_IMG_WIDTH_IPHONE5);
    } else if ([DCDevice isIphone4]) {
        return (BG_IMG_WIDTH_IPHONE4);
    }
    else if ([DCDevice isIpad]) {
        return (BG_IMG_WIDTH_IPAD);
    } else if ([DCDevice isIpadRetina]) {
        return (BG_IMG_WIDTH_IPAD_RETINA);
    }
    return (BG_IMG_WIDTH_IPHONE5);
}

//背景画像の縦幅取得
- (int)backgroundImageHeight
{
    if ([DCDevice isIphone5]) {
        return (BG_IMG_HEIGHT_IPHONE5);
    } else if ([DCDevice isIphone4]) {
        return (BG_IMG_HEIGHT_IPHONE4);
    }
    else if ([DCDevice isIpad]) {
        return (BG_IMG_HEIGHT_IPAD);
    } else if ([DCDevice isIpadRetina]) {
        return (BG_IMG_HEIGHT_IPAD_RETINA);
    }
    return (BG_IMG_HEIGHT_IPHONE5);
}

#pragma mark mask image

//画像にマスク適用
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

#pragma mark resize image

//画像のリサイズ
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

#pragma mark get image file

//画像ファイル名取得
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

//画像ファイル取得
+ (UIImage *)getUIImageFromResources:(NSString*)fileName ext:(NSString*)ext
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:ext];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
    return (img);
}

@end
