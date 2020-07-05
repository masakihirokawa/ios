//
//  DCDate.h
//
//  Created by Masaki Hirokawa on 2013/09/10.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCDate : NSObject

#pragma mark - enumerator
typedef NS_ENUM(NSUInteger, pickerStyleId) {
    PICKER_STYLE_WHEELS    = 0,
    PICKER_STYLE_INLINE    = 1,
    PICKER_STYLE_COMPACT   = 2,
    PICKER_STYLE_AUTOMATIC = 3
};

#pragma mark - public method
+ (UIDatePicker *)picker:(id)delegate rect:(CGRect)rect mode:(UIDatePickerMode)mode minuteInterval:(NSUInteger)minuteInterval
                dateText:(NSString *)dateText dateFormat:(NSString *)dateFormat
         backgroundColor:(UIColor *)backgroundColor action:(SEL)action;
+ (UIDatePicker *)pickerWithStyle:(id)delegate rect:(CGRect)rect styleId:(NSUInteger)styleId mode:(UIDatePickerMode)mode minuteInterval:(NSUInteger)minuteInterval
                         dateText:(NSString *)dateText dateFormat:(NSString *)dateFormat
                  backgroundColor:(UIColor *)backgroundColor action:(SEL)action API_AVAILABLE(ios(14.0));
+ (void)setPickerStyle:(UIDatePickerStyle)style API_AVAILABLE(ios(14.0));
+ (NSDate *)date:(NSString *)dateText dateFormat:(NSString *)dateFormat;
+ (NSString *)dateText:(NSString *)dateFormat;
+ (NSInteger)pickerYear;
+ (NSInteger)pickerMonth;
+ (NSInteger)pickerDay;
+ (NSInteger)pickerHour;
+ (NSInteger)pickerMinute;
+ (NSInteger)currentYear;
+ (NSInteger)currentMonth;
+ (NSInteger)currentDay;
+ (NSInteger)currentHour;
+ (NSInteger)currentMinute;
+ (NSInteger)currentSecond;
+ (NSDateComponents *)currentDateComponents;
+ (NSDate *)today:(NSDate *)referenceDate;
+ (NSUInteger)hourConsideringTimeZone:(NSDate *)referenceDate;
+ (NSDateComponents *)dateComponents:(NSCalendar *)calender fromDate:(NSDate *)fromDate;
+ (BOOL)isCurrentDate;
+ (BOOL)isCurrentTime;
+ (CGFloat)since:(NSString *)referenceDateString targetDateString:(NSString *)targetDateString dateFormat:(NSString *)dateFormat dateUnit:(NSUInteger)dateUnit;
+ (NSString *)hoursFromTimeInterval:(NSTimeInterval)interval;
+ (NSString *)minutesFromTimeInterval:(NSTimeInterval)interval;

@end
