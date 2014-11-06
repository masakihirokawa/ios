//
//  DCDevice.m
//
//  Created by Masaki Hirokawa on 2013/03/24.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCDevice.h"

@implementation DCDevice

static CGFloat const SCR_WIDTH          = 320.0;
static CGFloat const SCR_WIDTH_4_7INCH  = 375.0;
static CGFloat const SCR_WIDTH_5_5INCH  = 414.0;
static CGFloat const SCR_HEIGHT_3_5INCH = 480.0;
static CGFloat const SCR_HEIGHT_4INCH   = 568.0;
static CGFloat const SCR_HEIGHT_4_7INCH = 667.0;
static CGFloat const SCR_HEIGHT_5_5INCH = 736.0;

// iOSデバイス名の取得
+ (NSUInteger)deviceId
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);
            if (result.height == SCR_HEIGHT_3_5INCH * 2){
                return IPHONE4;
            }
            
            if (result.height == SCR_HEIGHT_4INCH * 2){
                return IPHONE5;
            }
            
            if (result.height == SCR_HEIGHT_4_7INCH * 2){
                return IPHONE6;
            }
            
            if (result.height == SCR_HEIGHT_5_5INCH * 2){
                return IPHONE6_PLUS;
            }
        } else {
            return IPHONE3;
        }
    } else {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            return IPAD_RETINA;
        } else {
            return IPAD;
        }
    }
    
    return UNKNOWN;
}

// iPhone 3G/3GSであるか
+ (BOOL)isIphone3
{
    return [DCDevice deviceId] == IPHONE3;
}

// iPhone 4/4sであるか
+ (BOOL)isIphone4
{
    return [DCDevice deviceId] == IPHONE4;
}

// iPhone 5s/5c/5であるか
+ (BOOL)isIphone5
{
    return [DCDevice deviceId] == IPHONE5;
}

// iPhone 6であるか
+ (BOOL)isIphone6
{
    return [DCDevice deviceId] == IPHONE6;
}

// iPhone 6 Plusであるか
+ (BOOL)isIphone6Plus
{
    return [DCDevice deviceId] == IPHONE6_PLUS;
}

// iPadであるか
+ (BOOL)isIpad
{
    return [DCDevice deviceId] == IPAD;
}

// iPad Retinaであるか
+ (BOOL)isIpadRetina
{
    return [DCDevice deviceId] == IPAD_RETINA;
}

// Retinaディスプレイであるか
+ (BOOL)isRetina
{
    return [DCDevice isIphone4] || [DCDevice isIphone5] || [DCDevice isIphone6] || [DCDevice isIphone6Plus] || [DCDevice isIpadRetina];
}

// 旧い端末であるか
+ (BOOL)isLegacy
{
    return [DCDevice isIphone3] || [DCDevice isIphone4] || [DCDevice isIpad];
}

// iOS6以降であるか
+ (BOOL)isIOS6
{
    NSString *osversion = [UIDevice currentDevice].systemVersion;
    NSArray  *a = [osversion componentsSeparatedByString:@"."];
    return ([(NSString *)[a objectAtIndex:0] intValue] >= 6);
}

// iOS7以降であるか
+ (BOOL)isIOS7
{
    NSString *osversion = [UIDevice currentDevice].systemVersion;
    NSArray  *a = [osversion componentsSeparatedByString:@"."];
    return ([(NSString *)[a objectAtIndex:0] intValue] >= 7);
}

// iOS7以降であるか
+ (BOOL)overIOS7
{
    return [DCDevice isIOS7];
}

// iOS8以降であるか
+ (BOOL)isIOS8
{
    NSString *osversion = [UIDevice currentDevice].systemVersion;
    NSArray  *a = [osversion componentsSeparatedByString:@"."];
    return ([(NSString *)[a objectAtIndex:0] intValue] >= 8);
}

// 3.5インチ端末であるか
+ (BOOL)is3_5inch
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    return (screenSize.width == SCR_WIDTH && screenSize.height == SCR_HEIGHT_3_5INCH);
}

// 4インチ端末であるか
+ (BOOL)is4inch
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    return (screenSize.width == SCR_WIDTH && screenSize.height == SCR_HEIGHT_4INCH);
}

// 4.7インチ端末であるか
+ (BOOL)is4_7inch
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    return (screenSize.width == SCR_WIDTH_4_7INCH && screenSize.height == SCR_HEIGHT_4_7INCH);
}

// 5.5インチ端末であるか
+ (BOOL)is5_5inch
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    return (screenSize.width == SCR_WIDTH_5_5INCH && screenSize.height == SCR_HEIGHT_5_5INCH);
}

// 4インチ以上の端末であるか
+ (BOOL)over4inch
{
    return [DCDevice is4inch] || [DCDevice is4_7inch] || [DCDevice is5_5inch];
}

// iOSのバージョン取得
+ (CGFloat)iOSVersion
{
    return ([[[UIDevice currentDevice] systemVersion] floatValue]);
}

// スクリーンの横幅を取得
+ (CGFloat)screenWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

// スクリーンの縦幅を取得
+ (CGFloat)screenHeight
{
    return [[UIScreen mainScreen] bounds].size.height;
}

// スクリーンのサイズを取得
+ (CGRect)screenRect
{
    return CGRectMake(0, 0, [DCDevice screenWidth], [DCDevice screenHeight]);
}

// スクリーンスケールが2倍であるか取得
+ (BOOL)renderAt2x
{
    return [UIScreen mainScreen].nativeScale >= 2.0 && [UIScreen mainScreen].nativeScale < 3.0;
}

// スクリーンスケールが3倍であるか取得
+ (BOOL)renderAt3x
{
    return [UIScreen mainScreen].nativeScale >= 3.0;
}

// 言語設定取得（日本語）
+ (BOOL)isJapaneseLanguage
{
    static BOOL isJapanese;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isJapanese = [currentLanguage compare:@"ja"] == NSOrderedSame;
    });
    
    return isJapanese;
}

// 言語設定取得（フランス語）
+ (BOOL)isFrenchLanguage
{
    static BOOL isFrench;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isFrench = [currentLanguage compare:@"fr"] == NSOrderedSame;
    });
    
    return isFrench;
}

// 言語設定取得（ロシア語）
+ (BOOL)isRussianLanguage
{
    static BOOL isRussian;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isRussian = [currentLanguage compare:@"ru"] == NSOrderedSame;
    });
    
    return isRussian;
}

// 言語設定取得（中国語）
+ (BOOL)isChineseLanguage
{
    static BOOL isChinese;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isChinese =
            [currentLanguage compare:@"zh-Hans"] == NSOrderedSame ||
            [currentLanguage compare:@"zh-Hant"] == NSOrderedSame;
    });
    
    return isChinese;
}

// 言語設定取得（韓国語）
+ (BOOL)isKoreanLanguage
{
    static BOOL isKorean;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isKorean = [currentLanguage compare:@"ko"] == NSOrderedSame;
    });
    
    return isKorean;
}

// 言語設定取得（タイ語）
+ (BOOL)isThaiLanguage
{
    static BOOL isThai;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isThai = [currentLanguage compare:@"th"] == NSOrderedSame;
    });
    
    return isThai;
}

// 言語設定取得（マルチバイト言語か否か）
+ (BOOL)isMultiByteLanguage
{
    return [DCDevice isJapaneseLanguage] || [DCDevice isRussianLanguage] || [DCDevice isChineseLanguage] ||
           [DCDevice isKoreanLanguage] || [DCDevice isThaiLanguage];
}

@end
