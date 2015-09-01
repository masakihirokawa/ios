//
//  DCDevice.h
//
//  Created by Masaki Hirokawa on 2013/03/24.
//  Copyright (c) 2013-2014 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCDevice : NSObject

#pragma mark - enumerator
typedef NS_ENUM(NSUInteger, deviceId) {
    IPHONE3      = 0,
    IPHONE4      = 1,
    IPHONE5      = 2,
    IPHONE6      = 3,
    IPHONE6_PLUS = 4,
    IPAD         = 5,
    IPAD_RETINA  = 6,
    UNKNOWN      = 7
};

#pragma mark - public method
+ (NSUInteger)deviceId;
+ (BOOL)      isIphone3;
+ (BOOL)      isIphone4;
+ (BOOL)      isIphone5;
+ (BOOL)      isIphone6;
+ (BOOL)      isIphone6Plus;
+ (BOOL)      isIpad;
+ (BOOL)      isIpadRetina;
+ (BOOL)      isRetina;
+ (BOOL)      isLegacy;
+ (BOOL)      is3_5inch;
+ (BOOL)      is4inch;
+ (BOOL)      is4_7inch;
+ (BOOL)      is5_5inch;
+ (BOOL)      over4inch;
+ (BOOL)      isIOS6;
+ (BOOL)      isIOS7;
+ (BOOL)      underIOS7;
+ (BOOL)      overIOS7;
+ (BOOL)      isIOS8;
+ (BOOL)      overIOS8;
+ (CGFloat)   iOSVersion;
+ (CGFloat)   screenWidth;
+ (CGFloat)   screenHeight;
+ (CGRect)    screenRect;
+ (BOOL)      renderAt2x;
+ (BOOL)      renderAt3x;
+ (BOOL)      vertual5_5inch;
+ (BOOL)      isJapaneseLanguage;
+ (BOOL)      isFrenchLanguage;
+ (BOOL)      isRussianLanguage;
+ (BOOL)      isChineseLanguage;
+ (BOOL)      isKoreanLanguage;
+ (BOOL)      isThaiLanguage;
+ (BOOL)      isMultiByteLanguage;

@end
