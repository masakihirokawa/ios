//
//  DCRandomize.m
//
//  Created by Masaki Hirokawa on 2013/09/06.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCRandomize.h"

@implementation DCRandomize

#pragma mark - Shuffle Array

// 配列をシャッフルして取得
+ (NSArray *)shuffleArray:(NSMutableArray *)array
{
    NSMutableArray *resultList = array;
    long i = [resultList count];
    while (--i) {
        int j = rand() % (i + 1);
        [resultList exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    return [NSMutableArray arrayWithArray:resultList];
}

#pragma mark - Shuffle

// 指定した範囲内の数値をシャッフルして配列取得
+ (NSArray *)shuffle:(NSInteger)min max:(NSInteger)max
{
    NSMutableArray *tmpList = [NSMutableArray array];
    long num = (max - min) + 1;
    for (int i = 0; i < num; i++) {
        [tmpList insertObject:[NSNumber numberWithInt:i + (int)min] atIndex:i];
    }
    return [DCRandomize shuffleArray:tmpList];
}

#pragma mark - Exact

// 指定した数値と異なる乱数を取得
+ (NSInteger)exact:(NSInteger)min max:(NSInteger)max exceptId:(NSInteger)exceptId
{
    NSInteger tmpId;
    do {
        tmpId = [DCRandomize range:min max:max];
    } while (tmpId == exceptId);
    return tmpId;
}

#pragma mark - Range

// 指定した範囲内の乱数を取得
+ (NSInteger)range:(NSInteger)min max:(NSInteger)max
{
    return min + arc4random_uniform(((int)max - (int)min) + 1);
}

@end
