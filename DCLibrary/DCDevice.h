//
//  DCDevice.h
//
//  Created by Masaki Hirokawa on 2013/03/24.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IPHONE_5    @"iPhone5"
#define IPHONE_4    @"iPhone4"
#define IPHONE_3    @"iPhone3"
#define IPAD_RETINA @"iPad Retina"
#define IPAD        @"iPad"

@interface DCDevice : NSString

#pragma mark - public method
+ (NSString *)iOSDevice;
+ (BOOL)      isIphone5;
+ (BOOL)      isIphone4;
+ (BOOL)      isIphone3;
+ (BOOL)      isIpad;
+ (BOOL)      isIpadRetina;
+ (BOOL)      is4inch;
+ (BOOL)      isIOS6;
+ (BOOL)      isIOS7;
+ (CGFloat)   iOSVersion;
+ (BOOL)      isJapaneseLanguage;
+ (BOOL)      isFrenchLanguage;
+ (BOOL)      isRussianLanguage;
+ (BOOL)      isChineseLanguage;
+ (BOOL)      isKoreanLanguage;
+ (BOOL)      isThaiLanguage;
+ (BOOL)      isMultiByteLanguage;

@end
