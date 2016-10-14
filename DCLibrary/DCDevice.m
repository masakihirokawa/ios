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

#pragma mark -

// iOSデバイス名の取得
+ (NSUInteger)deviceId
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat const scale = [UIScreen mainScreen].scale;
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

// iOS 6以降であるか
+ (BOOL)isIOS6
{
    NSString *const osversion = [UIDevice currentDevice].systemVersion;
    NSArray  *const a = [osversion componentsSeparatedByString:@"."];
    
    return ([(NSString *)[a objectAtIndex:0] intValue] >= 6);
}

// iOS 7以降であるか
+ (BOOL)isIOS7
{
    NSString *const osversion = [UIDevice currentDevice].systemVersion;
    NSArray  *const a = [osversion componentsSeparatedByString:@"."];
    
    return ([(NSString *)[a objectAtIndex:0] intValue] >= 7);
}

// iOS 7以前であるか
+ (BOOL)underIOS7
{
    NSString *const osversion = [UIDevice currentDevice].systemVersion;
    NSArray  *const a = [osversion componentsSeparatedByString:@"."];
    
    return ([(NSString *)[a objectAtIndex:0] intValue] <= 7);
}

// iOS 7以降であるか
+ (BOOL)overIOS7
{
    return [DCDevice isIOS7];
}

// iOS 8以降であるか
+ (BOOL)isIOS8
{
    NSString *const osversion = [UIDevice currentDevice].systemVersion;
    NSArray  *const a = [osversion componentsSeparatedByString:@"."];
    
    return ([(NSString *)[a objectAtIndex:0] intValue] >= 8);
}

// iOS 8以降であるか
+ (BOOL)overIOS8
{
    return [DCDevice isIOS8];
}

// iOS 9以降であるか
+ (BOOL)isIOS9
{
    NSString *const osversion = [UIDevice currentDevice].systemVersion;
    NSArray  *const a = [osversion componentsSeparatedByString:@"."];
    
    return ([(NSString *)[a objectAtIndex:0] intValue] >= 9);
}

// iOS 9以降であるか
+ (BOOL)overIOS9
{
    return [DCDevice isIOS9];
}

// iOS 10以降であるか
+ (BOOL)isIOS10
{
    NSString *const osversion = [UIDevice currentDevice].systemVersion;
    NSArray  *const a = [osversion componentsSeparatedByString:@"."];
    
    return ([(NSString *)[a objectAtIndex:0] intValue] >= 10);
}

// iOS 10以降であるか
+ (BOOL)overIOS10
{
    return [DCDevice isIOS10];
}

// 3.5インチ端末であるか
+ (BOOL)is3_5inch
{
    CGSize const screenSize = [[UIScreen mainScreen] bounds].size;
    
    return (screenSize.width == SCR_WIDTH && screenSize.height == SCR_HEIGHT_3_5INCH);
}

// 4インチ端末であるか
+ (BOOL)is4inch
{
    CGSize const screenSize = [[UIScreen mainScreen] bounds].size;
    
    return (screenSize.width == SCR_WIDTH && screenSize.height == SCR_HEIGHT_4INCH);
}

// 4インチ以上の端末であるか
+ (BOOL)over4inch
{
    return [DCDevice is4inch] || [DCDevice is4_7inch] || [DCDevice is5_5inch];
}

// 4.7インチ端末であるか
+ (BOOL)is4_7inch
{
    CGSize const screenSize = [[UIScreen mainScreen] bounds].size;
    
    return (screenSize.width == SCR_WIDTH_4_7INCH && screenSize.height == SCR_HEIGHT_4_7INCH);
}

// 4.7インチ以上の端末であるか
+ (BOOL)over4_7inch
{
    CGSize const screenSize = [[UIScreen mainScreen] bounds].size;
    
    return (screenSize.width >= SCR_WIDTH_4_7INCH && screenSize.height >= SCR_HEIGHT_4_7INCH);
}

// 5.5インチ端末であるか
+ (BOOL)is5_5inch
{
    CGSize const screenSize = [[UIScreen mainScreen] bounds].size;
    
    return (screenSize.width == SCR_WIDTH_5_5INCH && screenSize.height == SCR_HEIGHT_5_5INCH);
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

// スクリーンのレクタングルを取得
+ (CGRect)screenRect
{
    return [[UIScreen mainScreen] bounds];
}

// スクリーンのサイズを取得
+ (CGSize)screenSize
{
    return [[UIScreen mainScreen] bounds].size;
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

// スクリーンスケールが拡大された5.5インチ端末のものであるか取得
+ (BOOL)vertual5_5inch
{
    if ([DCDevice underIOS7]) {
        return NO;
    }
    
    return [UIScreen mainScreen].nativeScale >= 2.608;
}

// 言語設定取得（日本語）
+ (BOOL)isJapaneseLanguage
{
    static BOOL isJapanese;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isJapanese = [currentLanguage compare:@"ja"] == NSOrderedSame ||
        [currentLanguage rangeOfString:@"ja"].location != NSNotFound;
    });
    
    return isJapanese;
}

// 言語設定取得（英語）
+ (BOOL)isEnglishLanguage
{
    static BOOL isEnglish;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isEnglish = [currentLanguage compare:@"en"] == NSOrderedSame ||
        [currentLanguage rangeOfString:@"en"].location != NSNotFound;
    });
    
    return isEnglish;
}

// 言語設定取得（フランス語）
+ (BOOL)isFrenchLanguage
{
    static BOOL isFrench;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isFrench = [currentLanguage compare:@"fr"] == NSOrderedSame ||
        [currentLanguage rangeOfString:@"fr"].location != NSNotFound;
    });
    
    return isFrench;
}

// 言語設定取得（イタリア語）
+ (BOOL)isItalianLanguage
{
    static BOOL isItalian;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isItalian = [currentLanguage compare:@"it"] == NSOrderedSame ||
        [currentLanguage rangeOfString:@"it"].location != NSNotFound;
    });
    
    return isItalian;
}

// 言語設定取得（ロシア語）
+ (BOOL)isRussianLanguage
{
    static BOOL isRussian;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isRussian = [currentLanguage compare:@"ru"] == NSOrderedSame ||
        [currentLanguage rangeOfString:@"ru"].location != NSNotFound;
    });
    
    return isRussian;
}

// 言語設定取得（簡体中国語）
+ (BOOL)isSimplifiedChineseLanguage
{
    static BOOL isSimplifiedChinese;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isSimplifiedChinese = [currentLanguage compare:@"zh-Hans"] == NSOrderedSame ||
        [currentLanguage rangeOfString:@"zh-Hans"].location != NSNotFound;
    });
    
    return isSimplifiedChinese;
}

// 言語設定取得（繁体中国語）
+ (BOOL)isTraditionalChineseLanguage
{
    static BOOL isTraditionalChinese;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isTraditionalChinese =
        ([currentLanguage compare:@"zh-Hant"] == NSOrderedSame || [currentLanguage rangeOfString:@"zh-Hant"].location != NSNotFound) ||
        ([currentLanguage compare:@"zh-TW"] == NSOrderedSame || [currentLanguage rangeOfString:@"zh-TW"].location != NSNotFound) ||
        ([currentLanguage compare:@"zh-HK"] == NSOrderedSame || [currentLanguage rangeOfString:@"zh-HK"].location != NSNotFound);
    });
    
    return isTraditionalChinese;
}

// 言語設定取得（韓国語）
+ (BOOL)isKoreanLanguage
{
    static BOOL isKorean;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isKorean = [currentLanguage compare:@"ko"] == NSOrderedSame ||
        [currentLanguage rangeOfString:@"ko"].location != NSNotFound;
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
        isThai = [currentLanguage compare:@"th"] == NSOrderedSame ||
        [currentLanguage rangeOfString:@"th"].location != NSNotFound;
    });
    
    return isThai;
}

// 言語設定取得（マルチバイト言語か否か）
+ (BOOL)isMultiByteLanguage
{
    return [DCDevice isJapaneseLanguage] || [DCDevice isRussianLanguage] || [DCDevice isTraditionalChineseLanguage] ||
    [DCDevice isSimplifiedChineseLanguage] || [DCDevice isKoreanLanguage] || [DCDevice isThaiLanguage];
}

@end
