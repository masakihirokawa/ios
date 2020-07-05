//
//  DCDevice.h
//
//  Created by Masaki Hirokawa on 2013/03/24.
//  Copyright (c) 2013-2014 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCR_RECT   [[UIScreen mainScreen] bounds]
#define SCR_SIZE   SCR_RECT.size
#define SCR_WIDTH  SCR_SIZE.width
#define SCR_HEIGHT SCR_SIZE.height

#define SCR_SIZE_3_5INCH CGSizeMake(320.0, 480.0)
#define SCR_SIZE_4INCH   CGSizeMake(320.0, 568.0)
#define SCR_SIZE_4_7INCH CGSizeMake(375.0, 667.0)
#define SCR_SIZE_5_5INCH CGSizeMake(414.0, 736.0)
#define SCR_SIZE_5_8INCH CGSizeMake(375.0, 812.0)

@interface DCDevice : NSObject

#pragma mark - enumerator
typedef NS_ENUM(NSUInteger, deviceId) {
    SCR_3_5INCH     = 0,
    SCR_4INCH       = 1,
    SCR_4_7INCH     = 2,
    SCR_5_5INCH     = 3,
    SCR_5_8INCH     = 4,
    SCR_IPAD        = 5,
    SCR_IPAD_RETINA = 6,
    SCR_UNKNOWN     = 7
};

#pragma mark - public method
+ (BOOL)isiOS6;
+ (BOOL)isiOS7;
+ (BOOL)isiOS8;
+ (BOOL)isiOS9;
+ (BOOL)isiOS10;
+ (BOOL)isiOS11;
+ (CGFloat)iOSVersion;

+ (BOOL)is3_5inch;
+ (BOOL)over3_5inch;
+ (BOOL)is4inch;
+ (BOOL)over4inch;
+ (BOOL)is4_7inch;
+ (BOOL)over4_7inch;
+ (BOOL)is5_5inch;
+ (BOOL)over5_5inch;
+ (BOOL)is5_8inch;
+ (BOOL)over5_8inch;
+ (CGRect)screenRect;
+ (CGSize)screenSize;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;
+ (BOOL)renderAt2x;
+ (BOOL)renderAt3x;
+ (BOOL)virtual5_5inch;
+ (BOOL)isiPad;
+ (BOOL)isiPadRetina;
+ (NSUInteger)screenSizeId;

+ (BOOL)isJapaneseLanguage;
+ (BOOL)isEnglishLanguage;
+ (BOOL)isFrenchLanguage;
+ (BOOL)isItalianLanguage;
+ (BOOL)isRussianLanguage;
+ (BOOL)isSimplifiedChineseLanguage;
+ (BOOL)isTraditionalChineseLanguage;
+ (BOOL)isKoreanLanguage;
+ (BOOL)isThaiLanguage;
+ (BOOL)isMultiByteLanguage;

@end
