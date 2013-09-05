//
//  DCAnimation.m
//
//  Created by Masaki Hirokawa on 2013/05/30.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCAnimation.h"

@implementation DCAnimation

@synthesize dc_delegate;
@synthesize targetView = _targetView;
@synthesize isBound = _isBound;

#pragma mark animations

//フェードアニメーション
- (void)fade:(UIView *)view duration:(float)duration isFadeIn:(BOOL)isFadeIn
{
    _targetView = view;
    [UIView beginAnimations:ANIM_ID_FADE context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:duration];
    _targetView.alpha = isFadeIn ? 0 : 1.0f;
    _targetView.alpha = isFadeIn ? 1.0f : 0;
    [UIView commitAnimations];
}

//スライドアニメーション
- (void)slide:(UIView *)view duration:(float)duration aimRect:(CGRect)rect
{
    _targetView = view;
    [UIView beginAnimations:ANIM_ID_SLIDE context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:duration];
    [_targetView setFrame:rect];
    [UIView commitAnimations];
}

//回転アニメーション
- (void)rotate:(UIView *)view duration:(float)duration aimAngle:(float)angle
{
    _targetView = view;
    [UIView beginAnimations:ANIM_ID_ROTATE context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:duration];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [_targetView setTransform:rotate];
    [UIView commitAnimations];
}

//拡縮アニメーション
- (void)scale:(UIView *)view duration:(float)duration aimScale:(float)scale
{
    _targetView = view;
    [UIView beginAnimations:ANIM_ID_SCALE context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:duration];
    CGAffineTransform aimScale = CGAffineTransformMakeScale(scale, scale);
    [_targetView setTransform:aimScale];
    [UIView commitAnimations];
}

//拡大アニメーション
- (void)scaleUp:(UIView *)view duration:(float)duration isBound:(BOOL)isBound
{
    _targetView = view;
    _targetView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    _targetView.alpha = 0;
    [UIView beginAnimations:ANIM_ID_SCALE_UP context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:duration];
    _isBound = isBound;
    _targetView.transform = CGAffineTransformMakeScale(_isBound ? 1.05f : 1.0f, _isBound ? 1.05f : 1.0f);
    _targetView.alpha = 1;
    [UIView commitAnimations];
}

//縮小アニメーション
- (void)scaleDown:(UIView *)view duration:(float)duration
{
    _targetView = view;
    [UIView beginAnimations:ANIM_ID_SCALE_DOWN context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:duration];
    _targetView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    _targetView.alpha = 0;
    [UIView commitAnimations];
}

//XY方向に平行移動
- (void)translate:(UIView *)view duration:(float)duration movePosition:(float)position
{
    _targetView = view;
    [UIView beginAnimations:ANIM_ID_TRANSLATE context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:duration];
    CGAffineTransform translate = CGAffineTransformMakeTranslation(position, position);
    [_targetView setTransform:translate];
    [UIView commitAnimations];
}

#pragma mark animation delegate

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if([animationID isEqualToString:ANIM_ID_FADE]) {
        if(finished) {
        }
    } else if([animationID isEqualToString:ANIM_ID_SLIDE]) {
        if(finished) {
        }
    } else if([animationID isEqualToString:ANIM_ID_ROTATE]) {
        if(finished) {
        }
    } else if([animationID isEqualToString:ANIM_ID_SCALE]) {
        if(finished) {
        }
    } else if([animationID isEqualToString:ANIM_ID_SCALE_UP]) {
        if(finished) {
            if (_isBound) {
                [UIView beginAnimations:nil context:nil];
                _targetView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                [UIView commitAnimations];
            }
        }
    } else if([animationID isEqualToString:ANIM_ID_SCALE_DOWN]) {
        if(finished) {
            _targetView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
    } else if([animationID isEqualToString:ANIM_ID_TRANSLATE]) {
        if(finished) {
        }
    }
    if(finished) {
        //ここでデリゲートメソッドを呼ぶ事ができます
        //[self.dc_delegate animFinish:animationID];
    }
}

@end
