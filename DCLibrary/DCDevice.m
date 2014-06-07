//
//  DCDevice.m
//
//  Created by Masaki Hirokawa on 2013/03/24.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCDevice.h"

@implementation DCDevice

static CGFloat const SCR_WIDTH          = 320.0;
static CGFloat const SCR_HEIGHT_4INCH   = 568.0;
static CGFloat const SCR_HEIGHT_3_5INCH = 480.0;

// iOSデバイス名の取得
+ (NSString *)iOSDevice
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);
            if(result.height == SCR_HEIGHT_3_5INCH * 2){
                return (IPHONE_4);
            }
            if(result.height == SCR_HEIGHT_4INCH * 2){
                return (IPHONE_5);
            }
        } else {
            return (IPHONE_3);
        }
    } else {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            return (IPAD_RETINA);
        } else {
            return (IPAD);
        }
    }
    return (@"unknown");
}

// iPhone 5端末であるか
+ (BOOL)isIphone5
{
    return ([[DCDevice iOSDevice] isEqualToString:IPHONE_5]);
}

// iPhone 4/4S端末であるか
+ (BOOL)isIphone4
{
    return ([[DCDevice iOSDevice] isEqualToString:IPHONE_4]);
}

// iPhone 3G/3GSであるか
+ (BOOL)isIphone3
{
    return ([[DCDevice iOSDevice] isEqualToString:IPHONE_3]);
}

// iPad端末であるか
+ (BOOL)isIpad
{
    return ([[DCDevice iOSDevice] isEqualToString:IPAD]);
}

// iPad Retina端末であるか
+ (BOOL)isIpadRetina
{
    return ([[DCDevice iOSDevice] isEqualToString:IPAD_RETINA]);
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

// 4インチ端末であるか
+ (BOOL)is4inch
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    return (screenSize.width == SCR_WIDTH && screenSize.height == SCR_HEIGHT_4INCH);
}

// iOSのバージョン取得
+ (CGFloat)iOSVersion
{
    return ([[[UIDevice currentDevice] systemVersion] floatValue]);
}

// iOSのスクリーンの横幅を取得
+ (CGFloat)screenWidth
{
    return SCR_WIDTH;
}

// iOSのバージョンに応じたスクリーンの縦幅取得
+ (CGFloat)screenHeight
{
    return [[UIScreen mainScreen] bounds].size.height;
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
