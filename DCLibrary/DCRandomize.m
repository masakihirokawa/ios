//
//  DCRandomize.m
//
//  Created by Masaki Hirokawa on 2013/09/06.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCRandomize.h"

@implementation DCRandomize

#pragma mark - Shuffle

// 配列をシャッフルして取得
+ (NSArray *)shuffleArray:(NSArray *)array
{
    NSMutableArray *shuffledList = [[NSMutableArray alloc] initWithArray:array];
    long i = [shuffledList count];
    while (--i) {
        int j = arc4random_uniform((int)i + 1);
        [shuffledList exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    
    return shuffledList;
}

// 指定した範囲内の数値をシャッフルして取得
+ (NSArray *)shuffle:(int)min max:(int)max
{
    NSMutableArray *tmpList = [NSMutableArray array];
    long num = (max - min) + 1;
    for (int i = 0; i < num; i++) {
        [tmpList insertObject:[NSNumber numberWithInt:i + min] atIndex:i];
    }
    
    return [DCRandomize shuffleArray:tmpList];
}

#pragma mark - Probability

// 0から指定した範囲の数値が返る
+ (NSInteger)probability:(int)specify
{
    return [DCRandomize range:0 max:specify];
}

#pragma mark - Range

// 指定した範囲内の乱数を取得
+ (NSInteger)range:(int)min max:(int)max
{
    return min + arc4random_uniform((max - min) + 1);
}

// 指定した数値と異なる乱数を取得
+ (NSInteger)exact:(int)min max:(int)max exceptId:(int)exceptId
{
    NSInteger tmpId;
    do {
        tmpId = [DCRandomize range:min max:max];
    } while (tmpId == exceptId);
    
    return tmpId;
}

@end
