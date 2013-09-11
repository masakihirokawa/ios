//
//  DCUtil.h
//
//  Created by Masaki Hirokawa on 2013/09/03.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCUtil : NSObject

#pragma mark method prototype
+ (void)setIdleTimerDisabled:(BOOL)isDisabled;
+ (void)socialShare:(id)delegate shareText:(NSString *)shareText shareImage:(UIImage *)shareImage;
+ (void)copyToPasteBoard:(NSString *)copyText completeAlertMessage:(NSString *)completeAlertMessage;
+ (void)openUrl:(NSString *)url;
+ (void)showAlert:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;
+ (NSString *)getStrFromPlist:(NSString *)key;

@end
