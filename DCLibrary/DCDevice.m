//
//  DCDevice.m
//
//  Created by Masaki Hirokawa on 2013/03/24.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCDevice.h"

@implementation DCDevice

#pragma mark - iOS version

// iOS 6であるか
+ (BOOL)isiOS6
{
    return [DCDevice iOSVersion] >= 6;
}

// iOS 7であるか
+ (BOOL)isiOS7
{
    return [DCDevice iOSVersion] >= 7;
}

// iOS 8であるか
+ (BOOL)isiOS8
{
    return [DCDevice iOSVersion] >= 8;
}

// iOS 9であるか
+ (BOOL)isiOS9
{
    return [DCDevice iOSVersion] >= 9;
}

// iOS 10であるか
+ (BOOL)isiOS10
{
    return [DCDevice iOSVersion] >= 10;
}

// iOS 11であるか
+ (BOOL)isiOS11
{
    return [DCDevice iOSVersion] >= 11;
}

// iOS 12であるか
+ (BOOL)isiOS12
{
    return [DCDevice iOSVersion] >= 12;
}

// iOS 13であるか
+ (BOOL)isiOS13
{
    return [DCDevice iOSVersion] >= 13;
}

// iOS 14であるか
+ (BOOL)isiOS14
{
    return [DCDevice iOSVersion] >= 14;
}

// iOSのバージョン取得
+ (CGFloat)iOSVersion
{
    NSString *const osversion = [UIDevice currentDevice].systemVersion;
    NSArray  *const a = [osversion componentsSeparatedByString:@"."];
    
    return [(NSString *)[a objectAtIndex:0] intValue];
}

#pragma mark - Screen size

// 3.5インチ端末であるか
+ (BOOL)is3_5inch
{
    return (SCR_WIDTH == SCR_SIZE_3_5INCH.width && SCR_HEIGHT == SCR_SIZE_3_5INCH.height);
}

// 3.5インチ以上の端末であるか
+ (BOOL)over3_5inch
{
    return (SCR_WIDTH >= SCR_SIZE_3_5INCH.width && SCR_HEIGHT >= SCR_SIZE_3_5INCH.height);
}

// 4インチ端末であるか
+ (BOOL)is4inch
{
    return (SCR_WIDTH == SCR_SIZE_4INCH.width && SCR_HEIGHT == SCR_SIZE_4INCH.height);
}

// 4インチ以上の端末であるか
+ (BOOL)over4inch
{
    return (SCR_WIDTH >= SCR_SIZE_4INCH.width && SCR_HEIGHT >= SCR_SIZE_4INCH.height);
}

// 4.7インチ端末であるか
+ (BOOL)is4_7inch
{
    return (SCR_WIDTH == SCR_SIZE_4_7INCH.width && SCR_HEIGHT == SCR_SIZE_4_7INCH.height);
}

// 4.7インチ以上の端末であるか
+ (BOOL)over4_7inch
{
    return (SCR_WIDTH >= SCR_SIZE_4_7INCH.width && SCR_HEIGHT >= SCR_SIZE_4_7INCH.height);
}

// 5.5インチ端末であるか
+ (BOOL)is5_5inch
{
    return (SCR_WIDTH == SCR_SIZE_5_5INCH.width && SCR_HEIGHT == SCR_SIZE_5_5INCH.height);
}

// 5.5インチ以上の端末であるか
+ (BOOL)over5_5inch
{
    return (SCR_WIDTH >= SCR_SIZE_5_5INCH.width && SCR_HEIGHT >= SCR_SIZE_5_5INCH.height);
}

// 5.8インチ端末であるか
+ (BOOL)is5_8inch
{
    return (SCR_WIDTH == SCR_SIZE_5_8INCH.width && SCR_HEIGHT == SCR_SIZE_5_8INCH.height);
}

// 5.8インチ以上の端末であるか
+ (BOOL)over5_8inch
{
    return (SCR_WIDTH >= SCR_SIZE_5_8INCH.width && SCR_HEIGHT >= SCR_SIZE_5_8INCH.height);
}

// 6.1インチ端末であるか
+ (BOOL)is6_1inch
{
    return (SCR_WIDTH == SCR_SIZE_6_1INCH.width && SCR_HEIGHT == SCR_SIZE_6_1INCH.height) && [DCDevice renderAt2x];
}

// 6.5インチ端末であるか
+ (BOOL)is6_5inch
{
    return (SCR_WIDTH == SCR_SIZE_6_5INCH.width && SCR_HEIGHT == SCR_SIZE_6_5INCH.height) && [DCDevice renderAt3x];
}

// iPhone Xシリーズの端末であるか
+ (BOOL)isiPhoneXSeries
{
    return [DCDevice is5_8inch] || [DCDevice is6_1inch] || [DCDevice is6_5inch];
}

// スクリーンのレクタングルを取得
+ (CGRect)screenRect
{
    return SCR_RECT;
}

// スクリーンのサイズを取得
+ (CGSize)screenSize
{
    return SCR_SIZE;
}

// スクリーンの横幅を取得
+ (CGFloat)screenWidth
{
    return SCR_WIDTH;
}

// スクリーンの縦幅を取得
+ (CGFloat)screenHeight
{
    return SCR_HEIGHT;
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
+ (BOOL)virtual5_5inch
{
    return [UIScreen mainScreen].nativeScale >= 2.608;
}

// iPadであるか
+ (BOOL)isiPad
{
    return [DCDevice screenSizeId] == SCR_IPAD;
}

// iPad Retinaであるか
+ (BOOL)isiPadRetina
{
    return [DCDevice screenSizeId] == SCR_IPAD_RETINA;
}

// スクリーンサイズID取得
+ (NSUInteger)screenSizeId
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat const scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);
            if (result.height == SCR_SIZE_3_5INCH.height * 2) {
                return SCR_3_5INCH;
            }
            
            if (result.height == SCR_SIZE_4INCH.height * 2) {
                return SCR_4INCH;
            }
            
            if (result.height == SCR_SIZE_4_7INCH.height * 2) {
                return SCR_4_7INCH;
            }
            
            if (result.height == SCR_SIZE_5_5INCH.height * 2) {
                return SCR_5_5INCH;
            }
            
            if (result.height == SCR_SIZE_5_8INCH.height * 2) {
                return SCR_5_8INCH;
            }
            
            if (result.height == SCR_SIZE_6_1INCH.height * 2 && [DCDevice renderAt2x]) {
                return SCR_6_1INCH;
            }
            
            if (result.height == SCR_SIZE_6_5INCH.height * 2 && [DCDevice renderAt3x]) {
                return SCR_6_5INCH;
            }
        }
    } else {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            return SCR_IPAD_RETINA;
        } else {
            return SCR_IPAD;
        }
    }
    
    return SCR_UNKNOWN;
}

#pragma mark - Language

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
