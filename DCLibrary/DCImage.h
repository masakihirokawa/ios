//
//  DCImage.h
//
//  Created by Masaki Hirokawa on 2013/05/24.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCDevice.h"

#define BG_IMG_EXT                @".jpg"
#define BG_IMG_TYPE_IPHONE5       @"_640_1136"
#define BG_IMG_TYPE_IPHONE4       @"_640_960"
#define BG_IMG_TYPE_IPAD          @"_1024_1024"
#define BG_IMG_TYPE_IPAD_RETINA   @"_2048_2048"
#define BG_IMG_WIDTH_IPHONE5      320
#define BG_IMG_HEIGHT_IPHONE5     568
#define BG_IMG_WIDTH_IPHONE4      320
#define BG_IMG_HEIGHT_IPHONE4     480
#define BG_IMG_WIDTH_IPAD         512
#define BG_IMG_HEIGHT_IPAD        512
#define BG_IMG_WIDTH_IPAD_RETINA  1024
#define BG_IMG_HEIGHT_IPAD_RETINA 1024

@interface DCImage : UIImage {
    NSInteger        backgroundImageX;
    NSInteger        backgroundImageY;
    NSInteger        backgroundImageWidth;
    NSInteger        backgroundImageHeight;
    NSMutableArray *_backgroundImageType;
    NSString       *backgroundImageExt;
}

#pragma mark property prototype
@property (nonatomic) NSInteger backgroundImageX;
@property (nonatomic) NSInteger backgroundImageY;
@property (nonatomic) NSInteger backgroundImageWidth;
@property (nonatomic) NSInteger backgroundImageHeight;
@property (nonatomic) NSString *backgroundImageExt;

#pragma mark method prototype
+ (UIImageView *)imageView:(NSString *)imageName imageExt:(NSString *)ext rect:(CGRect)rect;
- (void)setBackgroundImageRectangle;
- (void)setBackgroundImageType;
- (void)setBackgroundImageExt:(NSString *)ext;
- (NSString *)backgroundImageFile:(NSString *)imageTitle;
- (NSString *)backgroundImageName:(NSString *)imageTitle;
- (NSString *)backgroundImageType;
- (int)backgroundImageWidth;
- (int)backgroundImageHeight;

#pragma mark getter method
+ (UIImage *)mask:(UIImage *)image withMask:(UIImage *)maskImage;
+ (UIImage *)resize:(UIImage *)image rect:(CGRect)rect;
+ (NSString *)getImgFileName:(NSString *)src;
+ (UIImage *)getUIImageFromResources:(NSString*)fileName ext:(NSString*)ext;

@end
