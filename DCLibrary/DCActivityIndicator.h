//
//  DCActivityIndicator.h
//
//  Created by Masaki Hirokawa on 2013/07/01.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define INDICATOR_LARGE_SIZE 50
#define INDICATOR_SMALL_SIZE 20

@interface DCActivityIndicator : UIActivityIndicatorView

#pragma mark - enumerator
typedef NS_ENUM(NSUInteger, styles) {
    GRAY        = 1,
    WHITE       = 2,
    WHITE_LARGE = 3
};

#pragma mark - public method
+ (void)start:(id)view center:(CGPoint)center styleId:(NSInteger)styleId hidesWhenStopped:(BOOL)hidesWhenStopped showOverlay:(BOOL)showOverlay;
+ (void)stop;
+ (BOOL)isAnimating;

@end
