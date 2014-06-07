//
//  DCUtil.h
//
//  Created by Masaki Hirokawa on 2013/09/03.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCUtil : NSObject

#pragma mark - public method
+ (void)setIdleTimerDisabled:(BOOL)isDisabled;
+ (void)socialShare:(id)delegate shareText:(NSString *)shareText shareImage:(UIImage *)shareImage;
+ (void)copyToPasteBoard:(NSString *)copyText completeAlertMessage:(NSString *)completeAlertMessage;
+ (void)openUrl:(NSString *)url;
+ (void)openReviewUrl:(NSString *)appStoreId;
+ (void)showAlert:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;
+ (NSString *)trimWhitespaceCharacterSet:(NSString *)string;
+ (NSString *)trimNewLineCharacterSet:(NSString *)string;
+ (NSString *)trimWhitespaceAndNewLineCharacterSet:(NSString *)string;
+ (NSString *)trimAlphanumericCharacterSet:(NSString *)string;
+ (NSString *)trimDicimalDigitCharacterSet:(NSString *)string;
+ (NSString *)trimFirstCharacterSet:(NSString *)string searchString:(NSString *)searchString;
+ (NSString *)omissionText:(NSString *)string maxBytes:(NSUInteger)maxBytes;
+ (NSString *)serverResponseStr:(NSString *)url httpMethod:(NSString *)httpMethod;
+ (NSArray *)sortArray:(NSArray *)array ascending:(BOOL)ascending;
+ (NSArray *)arrayByRange:(int)min max:(int)max;
+ (NSString *)getStrFromPlist:(NSString *)key;

@end
