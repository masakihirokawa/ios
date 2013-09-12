//
//  DCClock.m
//
//  Created by Masaki Hirokawa on 2013/09/05.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCClock.h"

@implementation DCClock

#pragma mark - Digital Clock Time

// デジタル時計の文字列取得
+ (NSString *)digitalClockTime:(NSInteger)seconds
{
    NSString *hour = [DCClock increaseDigits:[DCClock hour:seconds] digits:1];
    NSString *min  = [DCClock increaseDigits:[DCClock min:seconds] digits:1];
    NSString *sec  = [DCClock increaseDigits:[DCClock sec:seconds] digits:1];
    return [NSString stringWithFormat:@"%@:%@:%@", hour, min, sec];
}

#pragma mark - Integer Time

// 時間を取得
+ (NSInteger)hour:(NSInteger)seconds
{
    return floor((seconds / MIN_SEC) / MIN_SEC);
}

// 分数を取得
+ (NSInteger)min:(NSInteger)seconds
{
    return floor((seconds / MIN_SEC) % MIN_SEC);
}

// 病数を取得
+ (NSInteger)sec:(NSInteger)seconds
{
    return floor(seconds % MIN_SEC);
}

#pragma mark - String Time

// 時間の文字列を取得
+ (NSString *)hourStr:(NSInteger)seconds
{
    return [NSString stringWithFormat:@"%d", [DCClock hour:seconds]];
}

// 分数の文字列を取得
+ (NSString *)minStr:(NSInteger)seconds
{
    return [NSString stringWithFormat:@"%d", [DCClock min:seconds]];
}

// 秒数の文字列を取得
+ (NSString *)secStr:(NSInteger)seconds
{
    return [NSString stringWithFormat:@"%d", [DCClock sec:seconds]];
}

#pragma mark - Util

// 桁数を増やす
+ (NSString *)increaseDigits:(NSInteger)value digits:(NSUInteger)digits
{
    NSString *valueStr = [NSString stringWithFormat:@"%d", value];
    if (value < TEN_SEC) {
        for (int i = 1; i <= digits; i++) {
            valueStr = [NSString stringWithFormat:@"%@%@", @"0", valueStr];
        }
    }
    return [NSString stringWithFormat:@"%@", valueStr];
}

@end
