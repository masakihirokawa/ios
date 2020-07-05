//
//  DCAudioPlayer.m
//
//  Created by Masaki Hirokawa on 2013/07/31.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import "DCAudioPlayer.h"

@implementation DCAudioPlayer

@synthesize ap_delegate;

CGFloat const VOLUME_SLIDER_WIDTH  = 220;
CGFloat const VOLUME_SLIDER_HEIGHT = 0;
CGFloat const MAX_VOLUME           = 1.0;
CGFloat const MIN_VOLUME           = 0.5f;

#pragma mark -

// 初期化
- (id)initWithAudio:(NSString *)fileName ext:(NSString *)ext isUseDelegate:(BOOL)isUseDelegate
{
    // オーディオプレイヤー初期化
    NSString *const filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:ext];
    NSURL    *const fileUrl  = [NSURL fileURLWithPath:filePath];
    
    NSError  *error = nil;
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
    
    // バックグラウンド再生を許可
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    // エラーでなければ処理実行
    if (!error) {
        // デリゲート指定
        if (isUseDelegate) {
            [_audioPlayer setDelegate:self];
        }
        
        // バッファを保持
        [_audioPlayer prepareToPlay];
    }
    
    return self;
}

// 再生
- (void)play
{
    if (_audioPlayer) {
        if (!_audioPlayer.isPlaying) {
            [_audioPlayer prepareToPlay];
            [_audioPlayer play];
        }
    }
}

// 一時停止
- (void)pause
{
    if (_audioPlayer) {
        if (_audioPlayer.isPlaying) {
            [_audioPlayer pause];
        }
    }
}

// 停止
- (void)stop
{
    if (_audioPlayer) {
        if (_audioPlayer.isPlaying) {
            [_audioPlayer setCurrentTime:0];
            [_audioPlayer stop];
            [_audioPlayer prepareToPlay];
        }
    }
}

// ボリュームコントロールスライダー
- (UISlider *)volumeControlSlider:(id)delegate point:(CGPoint)point defaultValue:(float)defaultValue selector:(SEL)selector
{
    UISlider *audioVolumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(point.x, point.y,
                                                                             VOLUME_SLIDER_WIDTH, VOLUME_SLIDER_HEIGHT)];
    audioVolumeSlider.minimumValue = 0.0;
    audioVolumeSlider.maximumValue = 1.0;
    if (defaultValue > MAX_VOLUME) defaultValue = MAX_VOLUME;
    if (defaultValue < MIN_VOLUME) defaultValue = MIN_VOLUME;
    audioVolumeSlider.value = defaultValue;
    
    [audioVolumeSlider addTarget:delegate action:selector forControlEvents:UIControlEventValueChanged];
    
    return audioVolumeSlider;
}

// ボリューム指定
- (void)setVolume:(float)volume
{
    if (_audioPlayer) {
        _audioPlayer.volume = volume;
    }
}

// 現在の再生フレーム指定
- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    if (_audioPlayer) {
        _audioPlayer.currentTime = currentTime;
    }
}

// 現在の再生フレーム取得
- (NSTimeInterval)currentTime
{
    return _audioPlayer.currentTime;
}

// オーディオの長さ取得
- (NSTimeInterval)duration
{
    return _audioPlayer.duration;
}

// ループ回数指定
- (void)setNumberOfLoops:(NSInteger)numberOfLoops
{
    if (_audioPlayer) {
        _audioPlayer.numberOfLoops = numberOfLoops;
    }
}

// 再生状況の取得
- (BOOL)isPlaying
{
    return _audioPlayer.playing;
}

#pragma mark - delegate method

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)successfully
{
    if (successfully) {
        
    }
}

@end
