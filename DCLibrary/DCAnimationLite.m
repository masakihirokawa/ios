//
//  DCAnimationLite.m
//
//  Created by Masaki Hirokawa on 2013/06/10.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCAnimationLite.h"

@implementation DCAnimationLite

#pragma mark -

// フェードアニメーション
+ (void)fade:(UIView *)imageView duration:(float)duration delay:(NSTimeInterval)delay isFadeIn:(BOOL)isFadeIn
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:delay];
    imageView.alpha = isFadeIn ? 0.0 : 1.0;
    imageView.alpha = isFadeIn ? 1.0 : 0.0;
    [UIView commitAnimations];
}

// スライドアニメーション
+ (void)slide:(UIView *)imageView duration:(float)duration delay:(NSTimeInterval)delay aimRect:(CGRect)rect
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:delay];
    [imageView setFrame:rect];
    [UIView commitAnimations];
}

// フェード＆スライドアニメーション
+ (void)fadeAndSlide:(UIView *)imageView duration:(float)duration delay:(NSTimeInterval)delay isFadeIn:(BOOL)isFadeIn aimRect:(CGRect)rect
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:delay];
    [imageView setFrame:rect];
    imageView.alpha = isFadeIn ? 0.0 : 1.0;
    imageView.alpha = isFadeIn ? 1.0 : 0.0;
    [UIView commitAnimations];
}

// 回転アニメーション
+ (void)rotate:(UIView *)imageView duration:(float)duration delay:(NSTimeInterval)delay aimAngle:(float)angle
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:delay];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(angle * (M_PI / 180.0));
    [imageView setTransform:rotate];
    [UIView commitAnimations];
}

// 拡縮アニメーション
+ (void)scale:(UIView *)imageView duration:(float)duration delay:(NSTimeInterval)delay aimScale:(float)scale
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:delay];
    CGAffineTransform aimScale = CGAffineTransformMakeScale(scale, scale);
    [imageView setTransform:aimScale];
    [UIView commitAnimations];
}

// 拡大アニメーション
+ (void)scaleUp:(UIView *)view duration:(float)duration delay:(NSTimeInterval)delay isBound:(BOOL)isBound boundScale:(CGFloat)boundScale
{
    view.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    view.alpha = 0.0;
    
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
        view.transform = CGAffineTransformMakeScale(isBound ? boundScale : 1.0, isBound ? boundScale : 1.0);
        view.alpha = 1.0;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:nil];
    }];
}

// 縮小アニメーション
+ (void)scaleDown:(UIView *)view duration:(float)duration delay:(NSTimeInterval)delay
{
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
        view.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        view.alpha = 0.0;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:nil];
    }];
}

// バウンドアニメーション
+ (void)bound:(UIView *)view duration:(float)duration delay:(NSTimeInterval)delay boundScale:(CGFloat)boundScale
{
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
        view.transform = CGAffineTransformMakeScale(boundScale, boundScale);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:nil];
    }];
}

// XY方向に平行移動
+ (void)translate:(UIView *)imageView duration:(float)duration delay:(NSTimeInterval)delay movePosition:(float)position
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    CGAffineTransform translate = CGAffineTransformMakeTranslation(position, position);
    [imageView setTransform:translate];
    [UIView commitAnimations];
}

@end
