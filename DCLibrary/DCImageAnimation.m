//
//  DCImageAnimation.m
//
//  Created by Masaki Hirokawa on 2013/06/04.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCImageAnimation.h"

@implementation DCImageAnimation

@synthesize dc_delegate;
@synthesize frameAnimationImageView = _frameAnimationImageView;
@synthesize timerAnimationImageView = _timerAnimationImageView;

NSInteger _animationImageX          = ANIM_IMAGE_X;
NSInteger _animationImageY          = ANIM_IMAGE_Y;
NSInteger _animationImageWidth      = ANIM_IMAGE_WIDTH;
NSInteger _animationImageHeight     = ANIM_IMAGE_HEIGHT;
CGFloat   _animationFps             = ANIM_FPS;
NSString *_animationImageExt        = ANIM_IMAGE_EXT;
NSString *_animationType;
NSTimer  *_animationTimer;
NSInteger _animationTimerCount      = 0;
BOOL      _isLoopAnimation          = NO;

#pragma mark - Init

// 初期化
- (id)init
{
    self = [super init];
    [self resetFps];
    [self resetRectangle];
    return self;
}

#pragma mark - Frame Animation

// アニメーション設定
- (void)startFrameAnimating:(NSString *)animationType
                           :(NSInteger)animationImageNum
                           :(NSString *)animationImagePrefix
                           :(NSInteger)animationRepeatNum
{
    // アニメーションの種類を保持
    _animationType = animationType;
    
    // イメージビュー初期化
    _frameAnimationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_animationImageX,
                                                                             _animationImageY,
                                                                             _animationImageWidth,
                                                                             _animationImageHeight)];
    
    // 最後の画像が消えないようにする
    _frameAnimationImageView.image = [self getUIImageFromResources:[self animationImageName:animationImagePrefix:animationImageNum]
                                                               ext:_animationImageExt];
    
    // 画像をタップ可能にする
    _frameAnimationImageView.userInteractionEnabled = YES;
    
    // アニメーションフレームを配列に入れる
    NSMutableArray *animationImageArray = [NSMutableArray array];
    for (int i = 1; i <= animationImageNum; i++) {
        [animationImageArray addObject:[self animationImageName:animationImagePrefix:i]];
    }
    _frameAnimationImageView.animationImages = [self animationImages:animationImageArray];
    
    // アニメーションの秒数を設定
    _frameAnimationImageView.animationDuration = [self animationSeconds:animationImageNum];
    
    // アニメーションのリピート回数を設定
    _frameAnimationImageView.animationRepeatCount = animationRepeatNum;
    
    // アニメーション開始
    [_frameAnimationImageView startAnimating];
    
    // アニメーション終了時のメソッド定義
    [self performSelector:@selector(animationDidFinish:)
               withObject:nil
               afterDelay:_frameAnimationImageView.animationDuration];
}

#pragma mark - Timer Animation

// アニメーション設定
- (void)startTimerAnimating:(NSString *)animationType
                           :(NSInteger)animationImageNum
                           :(NSString *)animationImagePrefix
                           :(BOOL)isLoopAnimation
{
    // アニメーションの種類を保持
    _animationType = animationType;
    
    // イメージビュー初期化
    _timerAnimationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_animationImageX,
                                                                             _animationImageY,
                                                                             _animationImageWidth,
                                                                             _animationImageHeight)];
    
    // 画像をタップ可能にする
    _timerAnimationImageView.userInteractionEnabled = YES;
    
    // アニメーションフレームを配列に入れる
    NSMutableArray *animationImageArray = [NSMutableArray array];
    for (int i = 1; i <= animationImageNum; i++) {
        [animationImageArray addObject:[self animationImageName:animationImagePrefix:i]];
    }
    
    // リピートの有無を格納
    _isLoopAnimation = isLoopAnimation;
    
    // アニメーションタイマー開始
    [self setAnimationTimerEvent:[self animationImages:animationImageArray]];
}

// アニメーションタイマーイベント発行
- (void)setAnimationTimerEvent:(NSArray *)animationImageList
{
    // タイマーに渡すパラメータ格納
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:animationImageList forKey:@"animationImageList"];
    
    // タイマー実行
    _animationTimer = [NSTimer scheduledTimerWithTimeInterval:[self animationTimerInterval]
                                                       target:self
                                                     selector:@selector(startAnimation:)
                                                     userInfo:userInfo
                                                      repeats:YES];
}

// タイマーアニメーション開始
- (void)startAnimation:(NSTimer *)timer
{
    NSArray *animationImageList = [(NSDictionary *)timer.userInfo objectForKey:@"animationImageList"];
    _timerAnimationImageView.image = [animationImageList objectAtIndex:_animationTimerCount];
    _animationTimerCount++;
    if ([animationImageList count] == _animationTimerCount) {
        // タイマー削除
        [self clearAnimationTimer];
        
        // 最終フレームの処理
        if (_isLoopAnimation) {
            // 再起処理
            [self setAnimationTimerEvent:animationImageList];
        } else {
            // アニメーション終了時のメソッド呼び出し
            [self animationDidStop];
        }
    }
}

// アニメーションタイマー削除
- (void)clearAnimationTimer
{
    if (_animationTimer != nil) {
        [_animationTimer invalidate];
    }
    _animationTimerCount = 0;
}

#pragma mark - delegate method

// アニメーション終了時のメソッド
- (void)animationDidFinish:(id)selector
{
    [self onEndAnimation];
}

// アニメーション終了時のメソッド
- (void)animationDidStop
{
    [self onEndAnimation];
}

// アニメーション終了時の処理
- (void)onEndAnimation
{
    // ここでデリゲートメソッドを呼ぶ事ができます
    
}

#pragma mark - setter method

// fps指定
- (void)setFps:(CGFloat)fps
{
    _animationFps = fps;
}

// fpsリセット
- (void)resetFps
{
    _animationFps = ANIM_FPS;
}

// レクタングル指定
- (void)setRectangle:(CGRect)rect
{
    _animationImageX      = rect.origin.x;
    _animationImageY      = rect.origin.y;
    _animationImageWidth  = rect.size.width;
    _animationImageHeight = rect.size.height;
}

// レクタングルリセット
- (void)resetRectangle
{
    [self setRectangle:CGRectMake(ANIM_IMAGE_X,
                                  ANIM_IMAGE_Y,
                                  ANIM_IMAGE_WIDTH,
                                  ANIM_IMAGE_HEIGHT)];
}

#pragma mark - getter method

// アニメーション秒数を取得
- (CGFloat)animationSeconds:(NSInteger)animationImageNum
{
    return (animationImageNum / _animationFps);
}

// アニメーションタイマーのインターバル取得
- (CGFloat)animationTimerInterval
{
    return (SECOND / _animationFps) / SECOND;
}

// アニメーション画像を取得
- (NSString *)animationImageName:(NSString *)animationImageSuffix
                                :(int)animationFrame
{
    return ([NSString stringWithFormat:@"%@%@", animationImageSuffix, [NSString stringWithFormat:@"%d", animationFrame]]);
}

// 画像ファイル名を配列で取得する
- (NSArray *)animationImages:(NSMutableArray *)animationImageNameList
{
    // 画像の配列を作成
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i < animationImageNameList.count; i++) {
        NSString *imageTitle = [animationImageNameList objectAtIndex:i];
        
        // 画像の配列に画像ファイルを追加
        [imageArray addObject:[self getUIImageFromResources:imageTitle
                                                        ext:_animationImageExt]];
    }
    return (imageArray);
}

// 画像リソースの取得
- (UIImage *)getUIImageFromResources:(NSString*)fileName ext:(NSString*)ext
{
	NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:ext];
	UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
	return (img);
}

@end
