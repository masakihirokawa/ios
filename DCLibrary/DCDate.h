//
//  DCDate.h
//
//  Created by Masaki Hirokawa on 2013/09/10.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCDate : NSObject

#pragma mark - enumerator
typedef NS_ENUM(NSUInteger, dateUnitId) {
    SEC  = 0,
    MIN  = 1,
    HOUR = 2,
    DAY  = 3
};

#pragma mark - public method
+ (UIDatePicker *)picker:(id)delegate rect:(CGRect)rect mode:(UIDatePickerMode)mode minuteInterval:(NSUInteger)minuteInterval dateText:(NSString *)dateText dateFormat:(NSString *)dateFormat action:(SEL)action;
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
+ (BOOL)isCurrentDate;
+ (BOOL)isCurrentTime;
+ (CGFloat)since:(NSString *)stringDate dateFormat:(NSString *)dateFormat dateUnit:(NSUInteger)dateUnit;

@end
