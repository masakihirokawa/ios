//
//  DCAnimationLite.m
//
//  Created by Masaki Hirokawa on 2013/06/10.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCAnimationLite.h"

@implementation DCAnimationLite

// フェードアニメーション
+ (void)fade:(UIView *)imageView duration:(float)duration isFadeIn:(BOOL)isFadeIn
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    imageView.alpha = isFadeIn ? 0 : 1.0f;
    imageView.alpha = isFadeIn ? 1.0f : 0;
    [UIView commitAnimations];
}

// スライドアニメーション
+ (void)slide:(UIView *)imageView duration:(float)duration aimRect:(CGRect)rect
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [imageView setFrame:rect];
    [UIView commitAnimations];
}

// 回転アニメーション
+ (void)rotate:(UIView *)imageView duration:(float)duration aimAngle:(float)angle
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [imageView setTransform:rotate];
    [UIView commitAnimations];
}

// 拡縮アニメーション
+ (void)scale:(UIView *)imageView duration:(float)duration aimScale:(float)scale
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    CGAffineTransform aimScale = CGAffineTransformMakeScale(scale, scale);
    [imageView setTransform:aimScale];
    [UIView commitAnimations];
}

// 拡大アニメーション
+ (void)scaleUp:(UIView *)view duration:(float)duration isBound:(BOOL)isBound boundScale:(CGFloat)boundScale
{
    view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    view.alpha = 0.0;
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:duration];
    view.transform = CGAffineTransformMakeScale(isBound ? boundScale : 1.0, isBound ? boundScale : 1.0);
    view.alpha = 1.0;
    
    [UIView setAnimationDelay:duration];
    view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    [UIView commitAnimations];
}

// 縮小アニメーション
+ (void)scaleDown:(UIView *)view duration:(float)duration
{
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:duration];
    view.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    view.alpha = 0.0;
    
    [UIView setAnimationDelay:duration];
    view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    [UIView commitAnimations];
}

// XY方向に平行移動
+ (void)translate:(UIView *)imageView duration:(float)duration movePosition:(float)position
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    CGAffineTransform translate = CGAffineTransformMakeTranslation(position, position);
    [imageView setTransform:translate];
    [UIView commitAnimations];
}

@end
