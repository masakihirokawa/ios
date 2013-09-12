//
//  DCTimer.m
//
//  Created by Masaki Hirokawa on 2013/06/05.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCTimer.h"

@implementation DCTimer

static NSTimer *timer;

// タイマー定義
+ (void)setTimer:(CGFloat)timeInterval delegate:(id)delegate selector:(SEL)selector userInfo:(NSDictionary *)userInfo
{
    timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                             target:delegate selector:selector userInfo:userInfo
                                            repeats:YES];
}

// タイマー削除
+ (void)clearTimer
{
    if (timer != nil) {
        [timer invalidate];
    }
}

// 遅延実行タイマー定義
+ (void)setDelayTimer:(CGFloat)timeInterval delegate:(id)delegate selector:(SEL)selector userInfo:(NSDictionary *)userInfo
{
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:delegate selector:selector userInfo:userInfo
                                    repeats:NO];
}

// タイマー取得
+ (NSTimer *)timer
{
    return timer;
}

@end
