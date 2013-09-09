//
//  DCRandomize.h
//
//  Created by Masaki Hirokawa on 2013/09/06.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCRandomize : NSObject

#pragma mark method prototype
+ (NSMutableArray *)shuffleArray:(NSMutableArray *)array;
+ (NSMutableArray *)shuffle:(NSInteger)min max:(NSInteger)max;
+ (NSInteger)exact:(NSInteger)min max:(NSInteger)max exceptId:(NSInteger)exceptId;
+ (NSInteger)range:(NSInteger)min max:(NSInteger)max;

@end
