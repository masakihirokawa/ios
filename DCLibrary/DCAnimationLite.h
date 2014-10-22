//
//  DCAnimationLite.h
//
//  Created by Masaki Hirokawa on 2013/06/10.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCAnimationLite : UIView

#pragma mark - public method
+ (void)fade:(UIView *)imageView duration:(float)duration delay:(NSTimeInterval)delay isFadeIn:(BOOL)isFadeIn;
+ (void)slide:(UIView *)imageView duration:(float)duration delay:(NSTimeInterval)delay aimRect:(CGRect)rect;
+ (void)rotate:(UIView *)imageView duration:(float)duration delay:(NSTimeInterval)delay aimAngle:(float)angle;
+ (void)scale:(UIView *)imageView duration:(float)duration delay:(NSTimeInterval)delay aimScale:(float)scale;
+ (void)scaleUp:(UIView *)view duration:(float)duration delay:(NSTimeInterval)delay isBound:(BOOL)isBound boundScale:(CGFloat)boundScale;
+ (void)scaleDown:(UIView *)view duration:(float)duration delay:(NSTimeInterval)delay;
+ (void)translate:(UIView *)imageView duration:(float)duration delay:(NSTimeInterval)delay movePosition:(float)position;

@end
