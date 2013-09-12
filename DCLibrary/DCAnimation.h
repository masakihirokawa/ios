//
//  DCAnimation.h
//
//  Created by Masaki Hirokawa on 2013/05/30.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ANIM_ID_FADE       @"animation_fade"
#define ANIM_ID_SLIDE      @"animation_slide"
#define ANIM_ID_ROTATE     @"animation_rotate"
#define ANIM_ID_SCALE      @"animation_scale"
#define ANIM_ID_SCALE_UP   @"animation_scale_up"
#define ANIM_ID_SCALE_DOWN @"animation_scale_down"
#define ANIM_ID_TRANSLATE  @"animation_translate"

@protocol DCAnimationDelegate;

@interface DCAnimation : UIView {
    id<DCAnimationDelegate>     _dc_delegate;
    UIView                      *_targetView;
    BOOL                        _isBound;
}

#pragma mark - property
@property (nonatomic, strong) id<DCAnimationDelegate> dc_delegate;
@property (nonatomic, retain) UIView *targetView;
@property (nonatomic, assign) BOOL isBound;

#pragma mark - public method
- (void)fade:(UIView *)view duration:(float)duration isFadeIn:(BOOL)isFadeIn;
- (void)slide:(UIView *)view duration:(float)duration aimRect:(CGRect)rect;
- (void)rotate:(UIView *)view duration:(float)duration aimAngle:(float)angle;
- (void)scale:(UIView *)view duration:(float)duration aimScale:(float)scale;
- (void)scaleUp:(UIView *)view duration:(float)duration isBound:(BOOL)isBound;
- (void)scaleDown:(UIView *)view duration:(float)duration;
- (void)translate:(UIView *)view duration:(float)duration movePosition:(float)position;

@end

#pragma mark - delegate method
@protocol DCAnimationDelegate <NSObject>
@optional
@end
