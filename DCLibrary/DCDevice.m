//
//  DCDevice.m
//
//  Created by Masaki Hirokawa on 2013/03/24.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCDevice.h"

@implementation DCDevice

// iOSデバイス名の取得
+ (NSString *)iOSDevice
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);
            if(result.height == 960){
                return (IPHONE_4);
            }
            if(result.height == 1136){
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
    NSArray *a = [osversion componentsSeparatedByString:@"."];
    return ([(NSString*)[a objectAtIndex:0] intValue] >= 6);
}

// iOS7以降であるか
+ (BOOL)isIOS7
{
    NSString *osversion = [UIDevice currentDevice].systemVersion;
    NSArray *a = [osversion componentsSeparatedByString:@"."];
    return ([(NSString*)[a objectAtIndex:0] intValue] >= 7);
}

// 4インチ端末であるか
+ (BOOL)is4inch
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    return (screenSize.width == 320.0 && screenSize.height == 568.0);
}

// iOSのバージョンを返す
+ (CGFloat)iOSVersion
{
    return ([[[UIDevice currentDevice] systemVersion] floatValue]);
}

// 言語設定取得
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

@end
