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
+ (void)copyToPasteBoard:(NSString *)copyText alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage delegate:(id)delegate;
+ (void)openUrl:(NSString *)url;
+ (void)openReviewUrl:(NSString *)appStoreId;
+ (void)showAlert:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;
+ (void)showAlertController:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles delegate:(id)delegate;
+ (NSString *)trimWhitespaceCharacterSet:(NSString *)string;
+ (NSString *)trimNewLineCharacterSet:(NSString *)string;
+ (NSString *)trimWhitespaceAndNewLineCharacterSet:(NSString *)string;
+ (NSString *)trimAlphanumericCharacterSet:(NSString *)string;
+ (NSString *)trimDicimalDigitCharacterSet:(NSString *)string;
+ (NSString *)trimFirstCharacterSet:(NSString *)string searchString:(NSString *)searchString;
+ (NSString *)omissionText:(NSString *)string maxBytes:(NSUInteger)maxBytes;
+ (NSString *)serverResponseStr:(NSString *)urlStr httpMethod:(NSString *)httpMethod;
+ (NSArray *)sortArray:(NSArray *)array ascending:(BOOL)ascending;
+ (NSArray *)sortArrayForNumber:(NSArray *)array ascending:(BOOL)ascending;
+ (NSArray *)distinctArray:(NSArray *)array;
+ (NSArray *)arrayByRange:(int)min max:(int)max;
+ (NSArray *)arrayCutout:(NSArray *)array start:(NSUInteger)start length:(NSUInteger)length;
+ (NSArray *)loopArray:(NSArray *)list index:(int)index;
+ (NSString *)getStrFromPlist:(NSString *)key;

@end
