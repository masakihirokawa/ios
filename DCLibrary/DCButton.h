//
//  DCButton.h
//
//  Created by Masaki Hirokawa on 2013/06/04.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCButton : UIButton

#pragma mark method prototype
+ (UIButton *)planeButton:(CGRect)frame text:(NSString *)text delegate:(id)delegate action:(SEL)action tag:(NSInteger)tag;
+ (UIButton *)imageButton:(CGRect)frame img:(UIImage *)img isHighlighte:(BOOL)isHighlighte on_img:(UIImage *)on_img delegate:(id)delegate action:(SEL)action tag:(NSInteger)tag;

@end
