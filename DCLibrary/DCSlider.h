//
//  DCSlider.h
//
//  Created by Masaki Hirokawa on 2013/09/10.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCSlider : UISlider

#pragma mark - public method
+ (UISlider *)planeSlider:(id)delegate rect:(CGRect)rect minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue defaultValue:(CGFloat)defaultValue continuous:(BOOL)continuous tag:(NSUInteger)tag valueChangedEvent:(SEL)valueChangedEvent touchDownEvent:(SEL)touchDownEvent touchUpEvent:(SEL)touchUpEvent;
+ (UISlider *)imageSlider:(id)delegate rect:(CGRect)rect minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue defaultValue:(CGFloat)defaultValue continuous:(BOOL)continuous thumbImage:(UIImage *)thumbImage thumbHighlitedImage:(UIImage *)thumbHighlitedImage minImage:(UIImage *)minImage maxImage:(UIImage *)maxImage tag:(NSUInteger)tag valueChangedEvent:(SEL)valueChangedEvent touchDownEvent:(SEL)touchDownEvent touchUpEvent:(SEL)touchUpEvent;
+ (CGFloat)xPositionFromSliderValue:(UISlider *)slider;

@end
