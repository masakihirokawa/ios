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

#pragma mark method prototype
+ (void)start:(id)view center:(CGPoint)center styleId:(NSInteger)styleId hidesWhenStopped:(BOOL)hidesWhenStopped showOverlay:(BOOL)showOverlay;
+ (void)stop;
+ (BOOL)isAnimating;

@end
