//
//  DCActivityIndicator.m
//
//  Created by Masaki Hirokawa on 2013/07/01.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCActivityIndicator.h"

@implementation DCActivityIndicator

static UIActivityIndicatorView *indicator_;
static UIView                  *overlay_;
static BOOL                    showOverlay_;

#pragma mark -

// アニメーション開始
+ (void)start:(id)view center:(CGPoint)center styleId:(NSInteger)styleId hidesWhenStopped:(BOOL)hidesWhenStopped showOverlay:(BOOL)showOverlay
{
    // インジケーター初期化
    DCActivityIndicator.indicator = [[UIActivityIndicatorView alloc] init];
    
    // スタイルを設定
    switch (styleId) {
        case DC_AI_GRAY:
            DCActivityIndicator.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            
            break;
        case DC_AI_WHITE:
            DCActivityIndicator.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            
            break;
        case DC_AI_WHITE_LARGE:
            DCActivityIndicator.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            
            break;
    }
    
    // スタイルに応じて寸法変更
    if (DCActivityIndicator.indicator.activityIndicatorViewStyle == UIActivityIndicatorViewStyleWhiteLarge) {
        DCActivityIndicator.indicator.frame = DC_AI_LARGE_RECT;
    } else {
        DCActivityIndicator.indicator.frame = DC_AI_SMALL_RECT;
    }
    
    // 座標をセンターに指定
    DCActivityIndicator.indicator.center = center;
    
    // 停止した時に隠れるよう設定
    DCActivityIndicator.indicator.hidesWhenStopped = hidesWhenStopped;
    
    // インジケーターアニメーション開始
    [DCActivityIndicator.indicator startAnimating];
    
    // オーバーレイ表示フラグ保持
    showOverlay_ = showOverlay;
    
    // オーバーレイ表示
    if (showOverlay_) {
        CGSize const screenSize = [[UIScreen mainScreen] bounds].size;
        overlay_ = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, screenSize.width, screenSize.height)];
        overlay_.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5f];
        [view addSubview:overlay_];
    }
    
    // 画面に追加
    [view addSubview:DCActivityIndicator.indicator];
}

// アニメーション停止
+ (void)stop
{
    if (showOverlay_) {
        [overlay_ removeFromSuperview];
    }
    [DCActivityIndicator.indicator stopAnimating];
}

// アニメーション中であるか
+ (BOOL)isAnimating
{
    return [DCActivityIndicator.indicator isAnimating];
}

+ (void)setIndicator:(UIActivityIndicatorView *)indicator
{
    indicator_ = indicator;
}

+ (UIActivityIndicatorView *)indicator
{
    return indicator_;
}

@end
