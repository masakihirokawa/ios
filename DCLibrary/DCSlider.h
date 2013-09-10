//
//  DCSlider.h
//
//  Created by Masaki Hirokawa on 2013/09/10.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCSlider : UISlider

#pragma mark method prototype
+ (UISlider *)planeSlider:(id)delegate rect:(CGRect)rect minVolume:(CGFloat)minVolume maxVolume:(CGFloat)maxVolume defaultVolume:(CGFloat)defaultVolume continuous:(BOOL)continuous tag:(NSUInteger)tag selector:(SEL)selector;
+ (UISlider *)imageSlider:(id)delegate rect:(CGRect)rect minVolume:(CGFloat)minVolume maxVolume:(CGFloat)maxVolume defaultVolume:(CGFloat)defaultVolume continuous:(BOOL)continuous thumbImage:(UIImage *)thumbImage thumbHighlitedImage:(UIImage *)thumbHighlitedImage minImage:(UIImage *)minImage maxImage:(UIImage *)maxImage tag:(NSUInteger)tag selector:(SEL)selector;

@end
