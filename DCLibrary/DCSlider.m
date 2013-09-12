//
//  DCSlider.m
//
//  Created by Masaki Hirokawa on 2013/09/10.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCSlider.h"

@implementation DCSlider

// スライダー取得
+ (UISlider *)planeSlider:(id)delegate rect:(CGRect)rect minVolume:(CGFloat)minVolume maxVolume:(CGFloat)maxVolume defaultVolume:(CGFloat)defaultVolume continuous:(BOOL)continuous tag:(NSUInteger)tag selector:(SEL)selector
{
    // スライダー生成
    UISlider *slider = [[UISlider alloc] initWithFrame:rect];
    
    // 値指定
    slider.minimumValue = minVolume;
    slider.maximumValue = maxVolume;
    slider.value = defaultVolume;
    if (defaultVolume > maxVolume) defaultVolume = maxVolume;
    if (defaultVolume < minVolume) defaultVolume = minVolume;
    
    // イベント指定
    slider.continuous = continuous;
    slider.tag = tag;
    [slider addTarget:delegate action:selector forControlEvents:UIControlEventValueChanged];
    
    return slider;
}

// 画像スライダー取得
+ (UISlider *)imageSlider:(id)delegate rect:(CGRect)rect minVolume:(CGFloat)minVolume maxVolume:(CGFloat)maxVolume defaultVolume:(CGFloat)defaultVolume continuous:(BOOL)continuous thumbImage:(UIImage *)thumbImage thumbHighlitedImage:(UIImage *)thumbHighlitedImage minImage:(UIImage *)minImage maxImage:(UIImage *)maxImage tag:(NSUInteger)tag selector:(SEL)selector
{
    // スライダー生成
    UISlider *imageSlider = [[UISlider alloc] initWithFrame:rect];
    
    // 値指定
    imageSlider.minimumValue = minVolume;
    imageSlider.maximumValue = maxVolume;
    imageSlider.value = defaultVolume;
    if (defaultVolume > maxVolume) defaultVolume = maxVolume;
    if (defaultVolume < minVolume) defaultVolume = minVolume;
    
    // 画像指定
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
    
    // イベント指定
    imageSlider.continuous = continuous;
    imageSlider.tag = tag;
    [imageSlider addTarget:delegate action:selector forControlEvents:UIControlEventValueChanged];
    
    return imageSlider;
}

@end
