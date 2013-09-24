//
//  DCDate.m
//
//  Created by Masaki Hirokawa on 2013/09/10.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCDate.h"

@implementation DCDate

static UIDatePicker *datePicker;

#pragma mark - Date Picker

// ピッカー取得
+ (UIDatePicker *)picker:(id)delegate rect:(CGRect)rect mode:(UIDatePickerMode)mode minuteInterval:(NSUInteger)minuteInterval dateText:(NSString *)dateText dateFormat:(NSString *)dateFormat action:(SEL)action
{
    // ピッカー初期化
    DCDate.datePicker = [[UIDatePicker alloc] initWithFrame:rect];

    // 背景色指定
    DCDate.datePicker.backgroundColor = [UIColor whiteColor];
    
    // 日付の表示モードを変更する
    DCDate.datePicker.datePickerMode = mode;
    
    // 何分刻みにするか
    DCDate.datePicker.minuteInterval = minuteInterval;
    
    // 初期時刻設定
    [DCDate.datePicker setDate:[DCDate date:dateText dateFormat:dateFormat]];
    
    // ピッカーの値が変更されたときに呼ばれるメソッドを設定
    [DCDate.datePicker addTarget:delegate action:action forControlEvents:UIControlEventValueChanged];
    
    return DCDate.datePicker;
}

// ピッカーに表示する時間取得
+ (NSDate *)date:(NSString *)dateText dateFormat:(NSString *)dateFormat
{
    NSString *dateString = dateText;
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:dateFormat];
    NSDate *date = [dateFormater dateFromString:dateString];
    return date;
}

// ピッカーで指定されている時間をテキストで取得
+ (NSString *)dateText:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return [dateFormatter stringFromDate:DCDate.datePicker.date];
}

// ピッカーで指定されている年取得
+ (NSInteger)pickerYear
{
    NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
    [yearFormatter setLocale:[NSLocale currentLocale]];
    [yearFormatter setDateFormat:@"yyyy"];
    NSString *pickerYear = [yearFormatter stringFromDate:DCDate.datePicker.date];
    return [pickerYear intValue];
}

// ピッカーで指定されている月取得
+ (NSInteger)pickerMonth
{
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    [monthFormatter setLocale:[NSLocale currentLocale]];
    [monthFormatter setDateFormat:@"MM"];
    NSString *pickerMonth = [monthFormatter stringFromDate:DCDate.datePicker.date];
    return [pickerMonth intValue];
}

// ピッカーで指定されている日付取得
+ (NSInteger)pickerDay
{
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setLocale:[NSLocale currentLocale]];
    [dayFormatter setDateFormat:@"dd"];
    NSString *pickerDay = [dayFormatter stringFromDate:DCDate.datePicker.date];
    return [pickerDay intValue];
}

// ピッカーで指定されている時刻(時)取得
+ (NSInteger)pickerHour
{
    NSDateFormatter *hourFormatter = [[NSDateFormatter alloc] init];
    [hourFormatter setLocale:[NSLocale currentLocale]];
    [hourFormatter setDateFormat:@"HH"];
    NSString *pickerHour = [hourFormatter stringFromDate:DCDate.datePicker.date];
    return [pickerHour intValue];
}

// ピッカーで指定されている時刻(分)取得
+ (NSInteger)pickerMinute
{
    NSDateFormatter *minuteFormatter = [[NSDateFormatter alloc] init];
    [minuteFormatter setLocale:[NSLocale currentLocale]];
    [minuteFormatter setDateFormat:@"mm"];
    NSString *pickerMinute = [minuteFormatter stringFromDate:DCDate.datePicker.date];
    return [pickerMinute intValue];
}

#pragma mark - Utils

// 現在の月を取得
+ (NSInteger)currentYear
{
    NSDateComponents *currentTimeComponents = [DCDate currentDateComponents];
    return currentTimeComponents.year;
}

// 現在の月を取得
+ (NSInteger)currentMonth
{
    NSDateComponents *currentTimeComponents = [DCDate currentDateComponents];
    return currentTimeComponents.month;
}

// 現在の日付を取得
+ (NSInteger)currentDay
{
    NSDateComponents *currentTimeComponents = [DCDate currentDateComponents];
    return currentTimeComponents.day;
}

// 現在の時間を取得
+ (NSInteger)currentHour
{
    NSDateComponents *currentTimeComponents = [DCDate currentDateComponents];
    return currentTimeComponents.hour;
}

// 現在の分数を取得
+ (NSInteger)currentMinute
{
    NSDateComponents *currentTimeComponents = [DCDate currentDateComponents];
    return currentTimeComponents.minute;
}

// 現在の秒数を取得
+ (NSInteger)currentSecond
{
    NSDateComponents *currentTimeComponents = [DCDate currentDateComponents];
    return currentTimeComponents.second;
}

// 現在時刻のコンポーネント取得
+ (NSDateComponents *)currentDateComponents
{
    // 現在の時刻を取得
    NSDate *nowDate = [NSDate date];
    
    // 現在時刻のコンポーネント定義
    NSDateComponents *nowComponents;
    nowComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit |
                                                              NSMonthCalendarUnit |
                                                              NSDayCalendarUnit |
                                                              NSHourCalendarUnit |
                                                              NSMinuteCalendarUnit |
                                                              NSSecondCalendarUnit)
                                                    fromDate:nowDate];
    return nowComponents;
}

#pragma mark - Decision

// ピッカーで指定されている日付が現在と同じであるか
+ (BOOL)isCurrentDate
{
    return ([DCDate currentYear] == [DCDate pickerYear] &&
            [DCDate currentMonth] == [DCDate pickerMonth] &&
            [DCDate currentDay] == [DCDate pickerDay]);
}

// ピッカーで指定されている時刻が現在時刻であるか
+ (BOOL)isCurrentTime
{
    return ([DCDate currentHour] == [DCDate pickerHour] &&
            [DCDate currentMinute] == [DCDate pickerMinute]);
}

#pragma mark - setter/getter method

+ (void)setDatePicker:(UIDatePicker *)picker
{
    datePicker = picker;
}

+ (UIDatePicker *)datePicker
{
    return datePicker;
}

@end
