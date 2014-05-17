//
//  DCUtil.m
//
//  Created by Masaki Hirokawa on 2013/09/03.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCUtil.h"

@implementation DCUtil

#pragma mark - Idle Timer

// 自動スリープ禁止の切り替え
+ (void)setIdleTimerDisabled:(BOOL)isDisabled
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:isDisabled];
}

#pragma mark - Social Share

// シェアする
+ (void)socialShare:(id)delegate shareText:(NSString *)shareText shareImage:(UIImage *)shareImage
{
    if([UIActivityViewController class]) {
        NSString *textToShare = shareText;
        UIImage *imageToShare = shareImage;
        NSArray *itemsToShare = [[NSArray alloc] initWithObjects:textToShare, imageToShare, nil];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
        activityVC.excludedActivityTypes = [[NSArray alloc] initWithObjects: UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeMessage, UIActivityTypePostToWeibo, nil];
        [delegate presentViewController:activityVC animated:YES completion:nil];
    }
}

#pragma mark - Copy to Paste Board

// ペーストボードにコピー
+ (void)copyToPasteBoard:(NSString *)copyText completeAlertMessage:(NSString *)completeAlertMessage
{
    // ペーストボードにコピー
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    [board setValue:copyText forPasteboardType:@"public.utf8-plain-text"];
    
    // コピー完了アラート表示
    [DCUtil showAlert:nil message:completeAlertMessage cancelButtonTitle:nil otherButtonTitles:nil];
}

#pragma mark - Open Url

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
    if ([DCUtil isIOS7]) {
        reviewUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appStoreId];
    } else {
        reviewUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software", appStoreId];
    }
    [DCUtil openUrl:reviewUrl];
}

#pragma mark - Show Alert

// アラート表示
+ (void)showAlert:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles
{
    if (otherButtonTitles == nil) otherButtonTitles = @"OK";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:otherButtonTitles, nil];
    [alert show];
}

#pragma mark - Trim Strings

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
        NSString *newString = [string substringWithRange:NSMakeRange(searchString.length, string.length - searchString.length)];
        return newString;
    }
    return string;
}

#pragma mark - Omission text

// テキストを指定したバイト数に省略し省略記号を付与
+ (NSString *)omissionText:(NSString *)string maxBytes:(NSUInteger)maxBytes
{
    const NSUInteger ELLIPSIS_BYTES = 1;
    NSString  *text = string;
    NSInteger textBytes = [text length];
    if (textBytes > maxBytes) {
        text = [NSString stringWithFormat:@"%@%@", [text substringToIndex:maxBytes - ELLIPSIS_BYTES], @"..."];
    }
    return text;
}

#pragma mark - Server response

// サーバのレスポンスを文字列で取得
+ (NSString *)serverResponseStr:(NSString *)url httpMethod:(NSString *)httpMethod
{
    NSMutableURLRequest *reqest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [reqest setHTTPMethod:httpMethod];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:reqest delegate:self];
    NSString        *responseStr;
    if (connection) {
        NSURLResponse *response = nil;
        NSError       *error    = nil;
        NSData        *responseData = [NSURLConnection sendSynchronousRequest:reqest returningResponse:&response error:&error];
        if (error) {
            responseStr = NULL;
        } else {
            responseStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        }
    } else {
        responseStr = NULL;
    }
    return responseStr;
}

#pragma mark - Get Str from info.plist

// info.plistから文字列取得
+ (NSString *)getStrFromPlist:(NSString *)key
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"string" ofType:@"plist"];
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *ret = [plist objectForKey:key];
    return [ret stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
}

#pragma mark - Utils

// iOS7以降であるか
+ (BOOL)isIOS7
{
    NSString *osversion = [UIDevice currentDevice].systemVersion;
    NSArray *a = [osversion componentsSeparatedByString:@"."];
    return ([(NSString*)[a objectAtIndex:0] intValue] >= 7);
}

@end
