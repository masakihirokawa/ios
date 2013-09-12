//
//  DCAudioPlayer.h
//
//  Created by Masaki Hirokawa on 2013/07/31.
//  Copyright (c) 2013 Masaki Hirokawa. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#define AUDIO_VOLUME_SLIDER_WIDTH  220
#define AUDIO_VOLUME_SLIDER_HEIGHT 0
#define AUDIO_MAX_VOLUME           1.0f
#define AUDIO_MIN_VOLUME           0.0f

@protocol DCAudioPlayerDelegate;

@interface DCAudioPlayer : AVAudioPlayer <AVAudioPlayerDelegate> {
    id<DCAudioPlayerDelegate> _ap_delegate;
}

#pragma mark - property
@property (nonatomic, assign)                 id<DCAudioPlayerDelegate> ap_delegate;
@property AVAudioPlayer                       *audioPlayer;
@property NSTimeInterval                      currentTime;
@property (readonly) NSData                   *data;
@property (assign) id <AVAudioPlayerDelegate> delegate;
@property NSTimeInterval                      duration;
@property (getter=isMeteringEnabled) BOOL     meteringEnabled;
@property (readonly) NSUInteger               numberOfChannels;
@property NSInteger                           numberOfLoops;
@property (readonly, getter=isPlaying) BOOL   playing;
@property (readonly) NSURL                    *url;
@property float                               volume;

#pragma mark - public method
- (id)initWithAudio:(NSString *)fileName ext:(NSString *)ext isUseDelegate:(BOOL)isUseDelegate;
- (void)play;
- (void)pause;
- (void)stop;
- (UISlider *)volumeControlSlider:(id)delegate point:(CGPoint)point defaultValue:(float)defaultValue selector:(SEL)selector;
- (void)setVolume:(float)volume;
- (void)setCurrentTime:(NSTimeInterval)currentTime;
- (void)setNumberOfLoops:(NSInteger)numberOfLoops;
- (BOOL)isPlaying;

@end

#pragma mark - delegate method
@protocol DCAudioPlayerDelegate <NSObject>
@optional
@end
