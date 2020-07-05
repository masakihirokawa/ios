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
+ (UIDatePicker *)picker:(id)delegate rect:(CGRect)rect mode:(UIDatePickerMode)mode minuteInterval:(NSUInteger)minuteInterval
                dateText:(NSString *)dateText dateFormat:(NSString *)dateFormat
         backgroundColor:(UIColor *)backgroundColor action:(SEL)action
{
    // ピッカー初期化
    DCDate.datePicker = [[UIDatePicker alloc] initWithFrame:rect];
    
    // 背景色指定
    DCDate.datePicker.backgroundColor = backgroundColor;
    
    // 日付の表示モードを変更する
    DCDate.datePicker.datePickerMode = mode;
    
    // 何分刻みにするかs
    DCDate.datePicker.minuteInterval = minuteInterval;
    
    // 初期時刻設定
    [DCDate.datePicker setDate:[DCDate date:dateText dateFormat:dateFormat]];
    
    // ピッカーの値が変更されたときに呼ばれるメソッドを設定
    [DCDate.datePicker addTarget:delegate action:action forControlEvents:UIControlEventValueChanged];
    
    return DCDate.datePicker;
}

// ピッカー取得（iOS 14.0以降）
+ (UIDatePicker *)pickerWithStyle:(id)delegate rect:(CGRect)rect styleId:(NSUInteger)styleId mode:(UIDatePickerMode)mode minuteInterval:(NSUInteger)minuteInterval
                         dateText:(NSString *)dateText dateFormat:(NSString *)dateFormat
                  backgroundColor:(UIColor *)backgroundColor action:(SEL)action API_AVAILABLE(ios(14.0))
{
    // ピッカー初期化
    DCDate.datePicker = [[UIDatePicker alloc] initWithFrame:rect];
    
    if (@available(iOS 14.0, *)) {
        if (styleId == PICKER_STYLE_WHEELS) {
            [DCDate.datePicker setPreferredDatePickerStyle:UIDatePickerStyleWheels];
        } else if (styleId == PICKER_STYLE_INLINE) {
            [DCDate.datePicker setPreferredDatePickerStyle:UIDatePickerStyleInline];
        } else if (styleId == PICKER_STYLE_COMPACT) {
            [DCDate.datePicker setPreferredDatePickerStyle:UIDatePickerStyleCompact];
        } else if (styleId == PICKER_STYLE_AUTOMATIC) {
            [DCDate.datePicker setPreferredDatePickerStyle:UIDatePickerStyleAutomatic];
        }
    }
    
    // 背景色指定
    DCDate.datePicker.backgroundColor = backgroundColor;
    
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

// ピッカーのスタイルを指定する
+ (void)setPickerStyle:(UIDatePickerStyle)style API_AVAILABLE(ios(14.0))
{
    if (@available(iOS 14.0, *)) {
        DCDate.datePicker.preferredDatePickerStyle = style;
    }
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
    nowComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth |
                                                              NSCalendarUnitDay | NSCalendarUnitHour |
                                                              NSCalendarUnitMinute | NSCalendarUnitSecond)
                                                    fromDate:nowDate];
    
    return nowComponents;
}

// 翌日の時刻に変換して取得
+ (NSDate *)today:(NSDate *)referenceDate
{
    NSDate *today = referenceDate;
    NSDate *tommorow = [today initWithTimeInterval:1 * 24 * 60 * 60 sinceDate:today];
    
    return tommorow;
}

// 時差を補正した時刻を取得
+ (NSUInteger)hourConsideringTimeZone:(NSDate *)referenceDate
{
    // 現在の日付を取得
    NSDate *nowDate = [NSDate date];
    
    // 時差を取得
    NSTimeZone *timeZone  = [NSTimeZone systemTimeZone];
    NSInteger  timeDiffSeconds = [timeZone secondsFromGMTForDate:nowDate];
    
    // 時差を補正した日付を保持
    NSDate *correctedDate = [referenceDate dateByAddingTimeInterval:timeDiffSeconds];
    
    // カレンダーをグレゴリオ暦で初期化
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    // 時差を補正した日付からコンポーネント取得
    NSDateComponents *correctedDateComponents = [DCDate dateComponents:calendar fromDate:correctedDate];
    
    return correctedDateComponents.hour;
}

// コンポーネント取得
+ (NSDateComponents *)dateComponents:(NSCalendar *)calender fromDate:(NSDate *)fromDate
{
    NSDateComponents *components = [calender components:(NSCalendarUnitYear | NSCalendarUnitMonth |
                                                         NSCalendarUnitHour | NSCalendarUnitMinute |
                                                         NSCalendarUnitSecond | NSCalendarUnitDay)
                                               fromDate:fromDate];
    
    return components;
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

#pragma mark - Since

typedef NS_ENUM(NSUInteger, dateUnitId) {
    SEC  = 0,
    MIN  = 1,
    HOUR = 2,
    DAY  = 3
};

// 指定した日付からの経過時間を取得
+ (CGFloat)since:(NSString *)referenceDateString targetDateString:(NSString *)targetDateString dateFormat:(NSString *)dateFormat dateUnit:(NSUInteger)dateUnit
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale systemLocale]];
    [dateFormatter setDateFormat:dateFormat];
    NSDate *referenceDate = [dateFormatter dateFromString:referenceDateString];
    NSDate *targetDate    = [dateFormatter dateFromString:targetDateString];
    NSTimeInterval since  = [targetDate timeIntervalSinceDate:referenceDate];
    if (dateUnit == SEC) {
        return since;
    } else if (dateUnit == MIN) {
        return since / 60;
    } else if (dateUnit == HOUR) {
        return since / (60 * 60);
    } else if (dateUnit == DAY) {
        return since / (24 * 60 * 60);
    }
    
    return since;
}

#pragma mark - Time Interval

+ (NSString *)hoursFromTimeInterval:(NSTimeInterval)interval
{
    NSInteger time = (NSInteger)interval;
    NSInteger seconds = time % 60;
    NSInteger minutes = (time / 60) % 60;
    NSInteger hours = (time / 3600);
    
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}

+ (NSString *)minutesFromTimeInterval:(NSTimeInterval)interval
{
    NSInteger time = (NSInteger)interval;
    NSInteger seconds = time % 60;
    NSInteger minutes = (time / 60) % 60;
    
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
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
