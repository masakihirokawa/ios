//
//  DCActivityIndicator.h
//
//  Created by Masaki Hirokawa on 2013/07/01.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCActivityIndicator : UIActivityIndicatorView

#pragma mark - enumerator
typedef NS_ENUM(NSUInteger, styles) {
    AI_GRAY        = 1,
    AI_WHITE       = 2,
    AI_WHITE_LARGE = 3
};

#pragma mark - public method
+ (void)start:(id)view center:(CGPoint)center styleId:(NSInteger)styleId hidesWhenStopped:(BOOL)hidesWhenStopped showOverlay:(BOOL)showOverlay;
+ (void)stop;
+ (BOOL)isAnimating;

@end
