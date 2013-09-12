//
//  DCImageAnimation.h
//
//  Created by Masaki Hirokawa on 2013/06/04.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SECOND                  60.0
#define ANIM_FPS                24.0
#define ANIM_IMAGE_X            0
#define ANIM_IMAGE_Y            0
#define ANIM_IMAGE_WIDTH        320
#define ANIM_IMAGE_HEIGHT       480
#define ANIM_IMAGE_HEIGHT_4INCH 568
#define ANIM_IMAGE_EXT          @"png"

@protocol DCImageAnimationDelegate;

@interface DCImageAnimation : UIImageView {
    id<DCImageAnimationDelegate> _dc_delegate;
}

#pragma mark - property
@property (nonatomic, assign) id<DCImageAnimationDelegate> dc_delegate;
@property (nonatomic, retain) UIImageView *frameAnimationImageView;
@property (nonatomic, retain) UIImageView *timerAnimationImageView;

#pragma mark - public method
- (id)init;
- (void)startFrameAnimating:(NSString *)animationType :(NSInteger)animationImageNum :(NSString *)animationImagePrefix :(NSInteger)animationRepeatNum;
- (void)startTimerAnimating:(NSString *)animationType :(NSInteger)animationImageNum :(NSString *)animationImagePrefix :(BOOL)isInfiniteLoopAnimation;
- (void)setFps:(CGFloat)fps;
- (void)resetFps;
- (void)setRectangle:(CGRect)rect;
- (void)resetRectangle;

@end

#pragma mark - delegate method
@protocol DCImageAnimationDelegate<NSObject>
@optional
@end
