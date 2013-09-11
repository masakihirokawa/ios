//
//  DCUtil.m
//
//  Created by Masaki Hirokawa on 2013/09/03.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCUtil.h"

@implementation DCUtil

#pragma mark set idle timer disabled

//スリープ禁止の切り替え
+ (void)setIdleTimerDisabled:(BOOL)isDisabled
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:isDisabled];
}

#pragma mark social share

//シェアする
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

#pragma mark copy to paste board

//ペーストボードにコピー
+ (void)copyToPasteBoard:(NSString *)copyText completeAlertMessage:(NSString *)completeAlertMessage
{
    //ペーストボードにコピー
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    [board setValue:copyText forPasteboardType:@"public.utf8-plain-text"];
    
    //コピー完了アラート表示
    [DCUtil showAlert:nil message:completeAlertMessage cancelButtonTitle:nil otherButtonTitles:nil];
}

#pragma mark open url

//URLを開く
+ (void)openUrl:(NSString *)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

#pragma mark show alert

//アラート表示
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

#pragma mark get str from plist

//info.plistから文字列取得
+ (NSString *)getStrFromPlist:(NSString *)key
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"string" ofType:@"plist"];
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *ret = [plist objectForKey:key];
    return [ret stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
}

@end
