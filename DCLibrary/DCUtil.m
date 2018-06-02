//
//  DCUtil.m
//
//  Created by Masaki Hirokawa on 2013/09/03.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCUtil.h"

@implementation DCUtil

#pragma mark - Idle timer

// 自動スリープ禁止の切り替え
+ (void)setIdleTimerDisabled:(BOOL)isDisabled
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:isDisabled];
}

#pragma mark - Copy to Paste Board

// ペーストボードにコピー
+ (void)copyToPasteBoard:(NSString *)copyText alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage delegate:(id)delegate
{
    // ペーストボードにコピー
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    [board setValue:copyText forPasteboardType:@"public.utf8-plain-text"];
    
    // コピー完了アラート表示
    if (@available(iOS 8, *)) {
        [DCUtil showAlertController:alertTitle message:alertMessage cancelButtonTitle:nil otherButtonTitles:nil delegate:delegate];
    } else {
        [DCUtil showAlert:alertTitle message:alertMessage cancelButtonTitle:nil otherButtonTitles:nil];
    }
}

#pragma mark - Open URL

// URLを開く
+ (void)openUrl:(NSString *)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

#pragma mark - Open Review URL

// AppStoreのレビューURLを開く
+ (void)openReviewUrl:(NSString *)appStoreId
{
    NSString *reviewUrl;
    if (@available(iOS 8, *)) {
        reviewUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?mt=8&action=write-review", appStoreId];
    } else if (@available(iOS 7, *)) {
        reviewUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?mt=8", appStoreId];
    } else {
        reviewUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software", appStoreId];
    }
    
    [DCUtil openUrl:reviewUrl];
}

// アプリ内レビューが使用可能か取得
+ (BOOL)availableStoreReviewController
{
    if (@available(iOS 10.3, *)) {
        if ([SKStoreReviewController class]) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - Show Alert

// アラート表示
+ (void)showAlert:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles
{
    if (otherButtonTitles == nil) {
        otherButtonTitles = NSLocalizedString(@"OK", nil);
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self
                                          cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    [alert show];
}

// アラート表示（iOS 8以降）
+ (void)showAlertController:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles delegate:(id)delegate
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    if (otherButtonTitles == nil) {
        otherButtonTitles = NSLocalizedString(@"OK", nil);
    }
    
    [alertController addAction:[UIAlertAction actionWithTitle:otherButtonTitles
                                                        style:UIAlertActionStyleDefault handler:nil]];
    
    [delegate presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Trim strings

// 前後にある半角スペースのトリミング
+ (NSString *)trimWhitespaceCharacterSet:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

// 前後にある改行のトリミング
+ (NSString *)trimNewLineCharacterSet:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

// 前後にある全角スペースと改行のトリミング
+ (NSString *)trimWhitespaceAndNewLineCharacterSet:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// 前後にあるアルファベット文字セットのトリミング
+ (NSString *)trimAlphanumericCharacterSet:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet alphanumericCharacterSet]];
}

// 前後にある数字の文字セットのトリミング
+ (NSString *)trimDicimalDigitCharacterSet:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
}

// 先頭の指定した文字列をトリミング
+ (NSString *)trimFirstCharacterSet:(NSString *)string searchString:(NSString *)searchString
{
    if ([string hasPrefix:searchString]) {
        NSString *const newString = [string substringWithRange:NSMakeRange(searchString.length, string.length - searchString.length)];
        
        return newString;
    }
    
    return string;
}

#pragma mark - Omission text

// テキストを指定したバイト数に省略し省略記号を付与
+ (NSString *)omissionText:(NSString *)string maxBytes:(NSUInteger)maxBytes
{
    NSUInteger const ELLIPSIS_BYTES = 1;
    NSInteger  const textBytes      = [string length];
    if (textBytes > maxBytes) {
        return [NSString stringWithFormat:@"%@%@", [string substringToIndex:maxBytes - ELLIPSIS_BYTES], @"..."];
    }
    
    return string;
}

#pragma mark - Server response

// サーバのレスポンスを文字列で取得
+ (NSString *)serverResponseStr:(NSString *)url httpMethod:(NSString *)httpMethod
{
    __block NSData *responseData = nil;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:30.0];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                         if (!error) {
                                             responseData = data;
                                         } else {
                                             responseData = NULL;
                                         }
                                     }] resume];
    
    if (responseData == NULL) {
        return NULL;
    }
    
    return [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
}

#pragma mark - Array

// 配列をソートして取得
+ (NSArray *)sortArray:(NSArray *)array ascending:(BOOL)ascending
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending:ascending];
    
    return [array sortedArrayUsingDescriptors:@[sortDescriptor]];
}

// 配列（Number型）をソートして取得
+ (NSArray *)sortArrayForNumber:(NSArray *)array ascending:(BOOL)ascending
{
    if (ascending) {
        NSArray *sortedNumberList = [array sortedArrayUsingComparator:^(id value1, id value2) {
            int intValueA = [(NSNumber *)value1 intValue];
            int intValueB = [(NSNumber *)value2 intValue];
            
            if (intValueA > intValueB) {
                return NSOrderedDescending;
            } else if(intValueA < intValueB) {
                return NSOrderedAscending;
            } else {
                return NSOrderedSame;
            }
        }];
        
        return sortedNumberList;
    } else {
        NSArray *sortedNumberList = [array sortedArrayUsingComparator:^(id value1, id value2) {
            int intValueA = [(NSNumber *)value2 intValue];
            int intValueB = [(NSNumber *)value1 intValue];
            
            if (intValueA > intValueB) {
                return NSOrderedDescending;
            } else if(intValueA < intValueB) {
                return NSOrderedAscending;
            } else {
                return NSOrderedSame;
            }
        }];
        
        return sortedNumberList;
    }
}

// 配列の重複データを削除して取得
+ (NSArray *)distinctArray:(NSArray *)array
{
    return [array valueForKeyPath:@"@distinctUnionOfObjects.self"];
}

// 最小値と最大値の範囲で配列を生成し取得
+ (NSArray *)arrayByRange:(int)min max:(int)max
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = min; i <= max; i++) {
        [array addObject:@(i)];
    }
    
    return array;
}

// 配列の範囲を指定し切り出したリストを取得
+ (NSArray *)arrayCutout:(NSArray *)array start:(NSUInteger)start length:(NSUInteger)length
{
    int range = (int)[array count] - (int)start;
    if (range < length) {
        return [array subarrayWithRange:NSMakeRange(start, range)];
    }
    
    return [array subarrayWithRange:NSMakeRange(start, length)];
}

// 配列をループして取得
+ (NSArray *)loopArray:(NSArray *)list index:(int)index
{
    NSMutableArray *loopList = [[NSMutableArray alloc] initWithArray:list];
    
    NSMutableArray *frontList = [[NSMutableArray alloc] init];
    for (int i = 0; i < index; i++) {
        [frontList addObject:loopList[i]];
    }
    
    for (int i = 0; i < [frontList count]; i++) {
        [loopList removeObjectAtIndex:0];
        [loopList addObject:frontList[i]];
    }
    
    return loopList;
}

#pragma mark - Colors

// 色をRGBカラーコードから変換して取得
+ (UIColor *)colorWithRedCode:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha
{
    CGFloat const redCode   = [DCUtil colorCode:red];
    CGFloat const greenCode = [DCUtil colorCode:green];
    CGFloat const blueCode  = [DCUtil colorCode:blue];
    
    return [UIColor colorWithRed:redCode green:greenCode blue:blueCode alpha:alpha];
}

// RGBカラーコード取得
+ (CGFloat)colorCode:(int)color
{
    int const rgbMax = 255;
    
    if (!color) {
        return 0.0;
    }
    
    if (color > rgbMax) {
        return 1.0;
    }
    
    return [@(color) floatValue] / rgbMax;
}

#pragma mark - Get strings from info.plist

// info.plistから文字列取得
+ (NSString *)getStrFromPlist:(NSString *)key
{
    NSString     *const path  = [[NSBundle mainBundle] pathForResource:@"string" ofType:@"plist"];
    NSDictionary *const plist = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString     *const ret   = [plist objectForKey:key];
    
    return [ret stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
}

#pragma mark - Number

// 桁数の取得
+ (int)digits:(int)value
{
    if (!value) {
        return 1;
    }
    
    return log10([@(value) doubleValue]) + 1;
}

#pragma mark - Local Authentication

// 顔認証・指紋認証が使用できるか取得
+ (BOOL)availableLocalAuthentication
{
    LAContext *context = [[LAContext alloc] init];
    
    return [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
}

// 顔認証に対応しているか取得
+ (BOOL)availableFaceId
{
     LAContext *context = [[LAContext alloc] init];
     if (@available(iOS 11, *)) {
         if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
             return context.biometryType == LABiometryTypeFaceID;
         }
     }
    
    return NO;
}

@end
