//
//  DCSlider.m
//
//  Created by Masaki Hirokawa on 2013/09/10.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCSlider.h"

@implementation DCSlider

// スライダー取得
+ (UISlider *)planeSlider:(id)delegate rect:(CGRect)rect minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue defaultValue:(CGFloat)defaultValue continuous:(BOOL)continuous tag:(NSUInteger)tag valueChangedEvent:(SEL)valueChangedEvent touchDownEvent:(SEL)touchDownEvent touchUpEvent:(SEL)touchUpEvent
{
    UISlider *slider = [[UISlider alloc] initWithFrame:rect];
    
    slider.minimumValue = minValue;
    slider.maximumValue = maxValue;
    
    if (defaultValue > maxValue) defaultValue = maxValue;
    if (defaultValue < minValue) defaultValue = minValue;
    slider.value = defaultValue;
    
    slider.continuous = continuous;
    slider.tag = tag;
    
    if (valueChangedEvent != nil) {
        [slider addTarget:delegate action:valueChangedEvent forControlEvents:UIControlEventValueChanged];
    }
    
    if (touchDownEvent != nil) {
        [slider addTarget:delegate action:touchDownEvent forControlEvents:UIControlEventTouchDown];
    }
    
    if (touchUpEvent != nil) {
        [slider addTarget:delegate action:touchUpEvent forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel)];
    }
    
    return slider;
}

// 画像スライダー取得
+ (UISlider *)imageSlider:(id)delegate rect:(CGRect)rect minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue defaultValue:(CGFloat)defaultValue continuous:(BOOL)continuous thumbImage:(UIImage *)thumbImage thumbHighlitedImage:(UIImage *)thumbHighlitedImage minImage:(UIImage *)minImage maxImage:(UIImage *)maxImage tag:(NSUInteger)tag valueChangedEvent:(SEL)valueChangedEvent touchDownEvent:(SEL)touchDownEvent touchUpEvent:(SEL)touchUpEvent
{
    UISlider *imageSlider = [[UISlider alloc] initWithFrame:rect];
    
    imageSlider.minimumValue = minValue;
    imageSlider.maximumValue = maxValue;
    
    if (defaultValue > maxValue) defaultValue = maxValue;
    if (defaultValue < minValue) defaultValue = minValue;
    imageSlider.value = defaultValue;
    
    UIImage *imageForThumb = thumbImage;
    UIImage *imageForThumbHighlited = thumbHighlitedImage;
    UIImage *imageMinBase = minImage;
    UIImage *imageForMin = [imageMinBase stretchableImageWithLeftCapWidth:4 topCapHeight:0];
    UIImage *imageMaxBase = maxImage;
    UIImage *imageForMax = [imageMaxBase stretchableImageWithLeftCapWidth:4 topCapHeight:0];
    [imageSlider setThumbImage:imageForThumb forState:UIControlStateNormal];
    [imageSlider setThumbImage:imageForThumbHighlited forState:UIControlStateHighlighted];
    [imageSlider setMinimumTrackImage:[imageForMin resizableImageWithCapInsets:UIEdgeInsetsFromString(@"4")]
                             forState:UIControlStateNormal];
    [imageSlider setMaximumTrackImage:[imageForMax resizableImageWithCapInsets:UIEdgeInsetsFromString(@"4")]
                             forState:UIControlStateNormal];
    
    imageSlider.continuous = continuous;
    imageSlider.tag = tag;
    
    if (valueChangedEvent != nil) {
        [imageSlider addTarget:delegate action:valueChangedEvent forControlEvents:UIControlEventValueChanged];
    }
    
    if (touchDownEvent != nil) {
        [imageSlider addTarget:delegate action:touchDownEvent forControlEvents:UIControlEventTouchDown];
    }
    
    if (touchUpEvent != nil) {
        [imageSlider addTarget:delegate action:touchUpEvent forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel)];
    }
    
    return imageSlider;
}

// スライダーのX座標取得
+ (CGFloat)xPositionFromSliderValue:(UISlider *)slider
{
    CGFloat const sliderRange  = slider.frame.size.width - slider.currentThumbImage.size.width;
    CGFloat const sliderOrigin = slider.frame.origin.x + (slider.currentThumbImage.size.width / 2);
    
    return (((slider.value - slider.minimumValue) / (slider.maximumValue - slider.minimumValue)) * sliderRange) + sliderOrigin;
}

@end
