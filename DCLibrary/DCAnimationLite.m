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
