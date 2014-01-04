//
//  DCSocial.m
//
//  Created by Masaki Hirokawa on 2013/06/28.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCSocial.h"

@implementation DCSocial

// Facebookへ投稿
+ (void)postToFacebook:(id)delegate text:(NSString *)text imageName:(NSString *)imageName url:(NSString *)url
{
    SLComposeViewController *slc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [slc setInitialText:text];
    [slc addImage:[UIImage imageNamed:imageName]];
    [slc addURL:[NSURL URLWithString:url]];
    [delegate presentViewController:slc animated:YES completion:nil];
}

// Twitterへ投稿
+ (void)postToTwitter:(id)delegate text:(NSString *)text imageName:(NSString *)imageName url:(NSString *)url
{
    SLComposeViewController *slc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [slc setInitialText:text];
    [slc addImage:[UIImage imageNamed:imageName]];
    [slc addURL:[NSURL URLWithString:url]];
    [delegate presentViewController:slc animated:YES completion:nil];
}

// LINEへ投稿
+ (void)postToLine:(NSString *)text
{
    NSString *plainString = text;
    NSString *contentKey = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                        (CFStringRef)plainString,
                                                                                        NULL,
                                                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                        kCFStringEncodingUTF8 );
    NSString *contentType = @"text";
    NSString *urlString = [NSString stringWithFormat: @"http://line.naver.jp/R/msg/%@/?%@", contentType, contentKey];
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

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

@end
