//
//  DCRandomize.h
//
//  Created by Masaki Hirokawa on 2013/09/06.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCRandomize : NSObject

#pragma mark - public method
+ (NSArray *)shuffleArray:(NSArray *)array;
+ (NSArray *)shuffle:(int)min max:(int)max;
+ (NSInteger)probability:(int)specify;
+ (NSInteger)range:(int)min max:(int)max;
+ (NSInteger)exact:(int)min max:(int)max exceptId:(int)exceptId;

@end
