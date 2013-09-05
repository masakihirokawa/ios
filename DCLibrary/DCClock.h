//
//  DCClock.h
//
//  Created by Masaki Hirokawa on 2013/09/05.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MIN_SEC 60
#define TEN_SEC 10

@interface DCClock : NSObject

#pragma mark method prototype
+ (NSString *)digitalClockTime:(NSInteger)seconds;
+ (NSInteger)hour:(NSInteger)seconds;
+ (NSInteger)min:(NSInteger)seconds;
+ (NSInteger)sec:(NSInteger)seconds;
+ (NSString *)hourStr:(NSInteger)seconds;
+ (NSString *)minStr:(NSInteger)seconds;
+ (NSString *)secStr:(NSInteger)seconds;
+ (NSString *)increaseDigits:(NSInteger)value digits:(NSUInteger)digits;

@end
