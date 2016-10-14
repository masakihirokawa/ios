//
//  DCActivityIndicator.h
//
//  Created by Masaki Hirokawa on 2013/07/01.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DC_AI_SMALL_RECT CGRectMake(0, 0, 20.0, 20.0)
#define DC_AI_LARGE_RECT CGRectMake(0, 0, 50.0, 50.0)

@interface DCActivityIndicator : UIActivityIndicatorView

#pragma mark - enumerator
typedef NS_ENUM(NSUInteger, styles) {
    DC_AI_GRAY        = 1,
    DC_AI_WHITE       = 2,
    DC_AI_WHITE_LARGE = 3
};

#pragma mark - public method
+ (void)start:(id)view center:(CGPoint)center styleId:(NSInteger)styleId hidesWhenStopped:(BOOL)hidesWhenStopped showOverlay:(BOOL)showOverlay;
+ (void)stop;
+ (BOOL)isAnimating;

@end
